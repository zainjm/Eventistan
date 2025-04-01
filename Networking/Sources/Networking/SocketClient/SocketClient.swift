//
//  SocketClient.swift
//  Networking
//
//  Created by Zain Ul Abe Din on 21/01/2025.
//

import Foundation
import SocketIO
import UIKit
import Types

private let chatBaseUrl = Bundle.main.object(forInfoDictionaryKey: "CHAT_BASE_URL") as? String ?? ""
private let chatPath = Bundle.main.object(forInfoDictionaryKey: "CHAT_PATH") as? String ?? ""
private let chatTenant = Bundle.main.object(forInfoDictionaryKey: "CHAT_TENANT") as? String ?? ""

public final class SocketClient {
    // MARK: - Properties
    private var socketManager: SocketManager!
    private var socket: SocketIOClient!
    private let tokenProvider: TokenProviderType
    private let apiClient: APIClientType
    public weak var delegate: SocketClientDelegate?
    private var ackCount: Int = .zero
    private let jsonDecoder = JSONDecoder()
    private var isSessionStarted: Bool = false
    private var timer: Timer?
    private var pendingRequests: [(router: SocketRouterType, decodableType: Decodable.Type, completion: (Result<Decodable?, Error>) -> Void)] = []
    
    // MARK: - Constants
    private enum Constant {
        static let idToken = "idToken"
        static let accessToken = "accessToken"
        static let tenant = "tenant"
        static let mode = "mode"
        static let version = "v"
        static let namespace = "/users-\(chatTenant)"
        static let ackTimeout = 30 * 1_000
        static let refreshSessionEvent = "refresh_session"
        static let sessionStartedEvent = "session_started"
        static let errorEvent = "error"
    }
    
    // MARK: - Initialization
    public init(tokenProvider: TokenProviderType, apiClient: APIClientType) {
        self.tokenProvider = tokenProvider
        self.apiClient = apiClient
        
        setupManager()
        setupObservers()
        addNotificationObservers()
    }
}

// MARK: - Setup
private extension SocketClient {
    func setupManager() {
        var shouldLogInfo: Bool = false
        #if DEBUG
        shouldLogInfo = true
        #endif
        socketManager = SocketManager(
            socketURL: URL(string: chatBaseUrl)!,
            config: [.secure(true), .log(shouldLogInfo), .compress, .path(chatPath), .forceWebsockets(true), .connectParams([Constant.tenant: chatTenant, Constant.mode: "full", Constant.version: "0.1.5"]), .reconnects(false)
            ]
        )
        
        socket = socketManager.socket(forNamespace: Constant.namespace)
        
        jsonDecoder.dateDecodingStrategy = .millisecondsSince1970
    }
    
    func setupObservers() {
        socket.on(clientEvent: .connect) { [weak self] data, ack in
            guard let self = self else { return }
            self.delegate?.socketClientDidConnect(self)
        }
        
        socket.on(Constant.sessionStartedEvent) { [weak self] data, ack in
            guard let self = self else { return }
            self.ackCount = .zero
            self.isSessionStarted = true
            self.delegate?.socketClient(self, didStartSession: data)
            self.handleResponse(data, completion: self.handleSocketSession(_:))
            self.performPendingRequests()
        }
        
        socket.on(Constant.refreshSessionEvent) { [weak self] data, ack in
            guard let self = self else { return }
            self.handleResponse(data, completion: self.handleSocketSession(_:))
        }
        
        socket.on(clientEvent: .error) { [weak self] data, ack in
            guard let self = self else { return }
            self.delegate?.socketClient(self, didReceiveError: data)
        }
        
        socket.on(clientEvent: .disconnect) { [weak self] data, ack in
            guard let self = self else { return }
            self.isSessionStarted = false
            self.delegate?.socketClientDidDisconnect(self)
        }
        
        socket.on(Constant.errorEvent) { [weak self] data, ack in
            guard let self = self else { return }
            var isUnauthorizedError: Bool = false
            for error in data {
                if ((error as? [String: Any])?["data"] as? [String: Any])?["code"] as? String == "unauthorized" {
                    isUnauthorizedError = true
                }
            }
            if isUnauthorizedError {
                refreshToken()
            } else {
                self.delegate?.socketClient(self, didReceiveError: data)
            }
        }
    }
}

// MARK: - Socket client
extension SocketClient: SocketClientType {
    public func start() {
        connect()
    }
    
    public func performRequest<T>(
        with router: any SocketRouterType,
        completion: @escaping (Result<T?, any Error>) -> Void
    ) where T : Decodable {
        performRequest(with: router, decodableType: T.self) { result in
            switch result {
            case .success(let decodable):
                completion(.success(decodable as? T))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    private func performRequest(
        with router: any SocketRouterType,
        decodableType: Decodable.Type,
        completion: @escaping (Result<Decodable?, any Error>) -> Void
    ) {
        if router.keepsObserving {
            socket.off(router.event)
            socket.on(router.event) { [weak self] data, _ in
                self?.handleResponse(data, decodableType: decodableType, completion: completion)
            }
        } else {
            guard socket.status == .connected else {
                pendingRequests.append((router: router, decodableType: decodableType, completion: completion))
                connect()
                return
            }
            socket.once(router.event) { [weak self] data, _ in
                self?.handleResponse(data, decodableType: decodableType, completion: completion)
            }
        }
        
        guard let request = router.request else { return }
        
        ackCount += 1
        let ackRequest = SocketAckRequest(timeout: Constant.ackTimeout, ack: ackCount)
        let items: [SocketData] = [request.asSocketData(), ackRequest.asSocketData()].compactMap({ $0 })
        socket.emit(router.event, with: items, completion: nil)
    }
}

// MARK: - Response handling
private extension SocketClient {
    func handleResponse<T: Decodable>(_ data: [Any], completion: @escaping (Result<T?, Error>) -> Void) {
        handleResponse(data, decodableType: T.self) { result in
            switch result {
            case .success(let response):
                completion(.success(response as? T))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func handleResponse(_ data: [Any], decodableType: Decodable.Type, completion: @escaping (Result<Decodable?, Error>) -> Void) {
        guard let responseData = data.first else {
            completion(.success(nil))
            return
        }
        do {
            let responseBinary = try JSONSerialization.data(withJSONObject: responseData)
            let response = try jsonDecoder.decode(decodableType, from: responseBinary)
            completion(.success(response))
        } catch {
            completion(.failure(error))
        }
    }
    
    func handleSocketSession(_ result: Result<SocketSession?, Error>) {
        unscheduleTimer()
        switch result {
        case .success(let session):
            guard let session else { return }
            scheduleTime(with: session.expiresIn)
        case .failure: break
        }
    }
    
    func performPendingRequests() {
        while !pendingRequests.isEmpty {
            let (router, decodableType, completion) = pendingRequests.removeFirst()
            performRequest(with: router, decodableType: decodableType, completion: completion)
        }
    }
}

// MARK: - Connection handling
private extension SocketClient {
    func addNotificationObservers() {
        NotificationCenter.default.addObserver(self, selector: #selector(connect), name: Notification.Name("tokenInfoDidChangeNotification"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(connect), name: Notification.Name("internetConnectionRecoveredNotification"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(connect), name: UIApplication.didBecomeActiveNotification, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(unscheduleTimer), name: Notification.Name("internetConnectionLostNotification"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(unscheduleTimer), name: UIApplication.willResignActiveNotification, object: nil)
    }
    
    @objc func unscheduleTimer() {
        timer?.invalidate()
        timer = nil
    }
    
    func scheduleTime(with expiryIn: TimeInterval) {
        timer = Timer.scheduledTimer(withTimeInterval: (expiryIn / 1000) - 30, repeats: false, block: { [weak self] _ in
            self?.refreshToken()
        })
    }
    
    @objc func connect() {
        guard let tokenInfo = tokenProvider.tokenInfo else {
            disconnect()
            return
        }
        guard socket.status != .connected else {
            refresh()
            return
        }
        
        guard isSessionStarted else {
            return startSession(tokenInfo: tokenInfo)
        }
        
        switch socket.status {
        case .disconnected, .notConnected:
            startSession(tokenInfo: tokenInfo)
        case .connected: refresh()
        case .connecting: break
        }
    }
    
    func startSession(tokenInfo: TokenInfo) {
        socket.connect(withPayload: [
            Constant.idToken: tokenInfo.idToken,
            Constant.accessToken: tokenInfo.accessToken
        ])
    }
    
    func disconnect() {
        isSessionStarted = false
        pendingRequests.removeAll()
        guard let socket else { return }
        socket.disconnect()
    }
    
    func refresh() {
        guard let tokenInfo = tokenProvider.tokenInfo else {
            disconnect()
            return
        }
        ackCount += 1
        let ackRequest = SocketAckRequest(timeout: Constant.ackTimeout, ack: ackCount)
        let refreshRequest = RefreshSessionRequest(accessToken: tokenInfo.accessToken, idToken: tokenInfo.idToken)
        let items: [SocketData] = [refreshRequest.asSocketData(), ackRequest.asSocketData()].compactMap({ $0 })
        socket.emit(Constant.refreshSessionEvent, with: items, completion: nil)
    }
}

// MARK: - API
private extension SocketClient {
    func refreshToken() {
        guard let refreshToken = tokenProvider.tokenInfo?.refreshToken else {
            disconnect()
            return
        }
        Task { [weak self] in await self?.refreshTokenAPI(with: refreshToken) }
    }
    
    func refreshTokenAPI(with refreshToken: String) async {
        let route = AuthenticationRouter.refreshToken(refreshToken: refreshToken)
        let result: Result<RefreshTokenResponse, APIFailure>? = await apiClient.performRequest(route: route)
        switch result {
        case .success(let response):
            await handleTokenInfoUpdate(TokenInfo(accessToken: response.accessToken, refreshToken: response.refreshToken, idToken: response.idToken))
        case .failure(let error):
            await handlerFailure(error)
        case .none: break
        }
    }
    
    @MainActor
    func handleTokenInfoUpdate(_ tokenInfo: TokenInfo) {
        tokenProvider.saveTokenInfo(tokenInfo)
    }
    
    @MainActor
    func handlerFailure(_ error: Error) {
        disconnect()
    }
}
