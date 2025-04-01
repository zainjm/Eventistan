//
//  APIClient.swift
//
//
//  Created by Zain Ul Abe Din on 03/10/2024.
//

import Foundation
import Alamofire
import Types
import Pulse

public final class APIClient {
    // MARK: - Properties
    var session: Session!
    private var decoder: APIDecoderType!
    private let sessionProvider: SessionProviderType
    private let tracker: TrackerType
    private let tokenProvider: TokenProviderType
    private var eventMonitor: NetworkEventMonitorType?
    private var networkMonitorUI: NetworkMonitorUI?
    
    // MARK: - Constants
    enum Constant {
        static let apiClientErrorCode: Int = -1047
    }
    
    // MARK: - Initializer
    init(
        sessionProvider: SessionProviderType,
        tracker: TrackerType,
        decoder: APIDecoderType,
        tokenProvider: TokenProviderType
    ) {
        self.sessionProvider = sessionProvider
        self.decoder = decoder
        self.tracker = tracker
        self.tokenProvider = tokenProvider
    }
    
    public convenience init(
        configuration: URLSessionConfiguration = .default,
        tokenProvider: TokenProviderType? = nil,
        appInfoProvider: AppInfoProviderType,
        securedKeyProvider: SecuredKeyProviderType,
        tracker: TrackerType
    ) {
        let eventMonitor = NetworkEventMonitor()
        self.init(
            sessionProvider: NetworkingSessionProvider(
                configuration: configuration,
                securedKeyProvider: securedKeyProvider,
                tokenProvider: tokenProvider!,
                eventMonitor: eventMonitor,
                tracker: tracker
            ),
            tracker: tracker,
            decoder: APIDecoder(tracker: tracker),
            tokenProvider: tokenProvider!
        )
        
        session = sessionProvider.makeTrustedSession(for: self)
        self.eventMonitor = eventMonitor
    }
}

extension APIClient: APIClientType {
    public func performRequest(
        route: any NetworkRouterType
    ) async -> Result<APISuccess, APIFailure> {
        let convertible = NetworkingConvertible(router: route, tokenProvider: tokenProvider)
        return await perform(route: convertible, session: session)
    }
    
    public func performRequest<T: Decodable>(
        route: any NetworkRouterType
    ) async -> Result<T, APIFailure> {
        let response = await performRequest(route: route)
        return decoder.decode(response, dateDecodingStrategy: route.dateDecodingStrategy)
    }
    
    public func startMonitoring() {
        eventMonitor?.addNetworkLogger(NetworkLogger())
        networkMonitorUI = NetworkMonitorUI.monitor()
    }
    
    public func stopMonitoring() {
        eventMonitor?.removeLoggers()
        networkMonitorUI?.stop()
        networkMonitorUI = nil
    }
}

// MARK: - Request performing
private extension APIClient {
    private func perform(
        route: URLRequestConvertible,
        session: Session
    ) async -> Result<APISuccess, APIFailure> {
        route.urlRequest?.log()
        return await withCheckedContinuation { [weak self] continuation in
            session.request(route).validate().response { response in
                response.response?.log(data: response.data)
                let responseCode = self?.getResponseCode(from: response) ?? Constant.apiClientErrorCode
                let result: Result<APISuccess, APIFailure>
                switch response.result {
                case .success:
                    result = .success(APISuccess(data: response.data ?? Data(), responseCode: responseCode))
                case .failure:
                    result = .failure(APIFailure(data: response.data, responseCode: responseCode))
                }
                continuation.resume(returning: result)
            }
        }
    }
}

// MARK: - Response handling
private extension APIClient {
    private func getResponseCode(from dataResponse: DataResponse<Data?, AFError>) -> Int {
        switch dataResponse.result {
        case .failure, .success:
            return dataResponse.response?.statusCode ??
            (dataResponse.error?.underlyingError as NSError?)?.code ??
            (dataResponse.error as NSError?)?.code ??
            NSURLErrorNotConnectedToInternet
        }
    }
    
    private func getResponseCode(from dataResponse: DataResponse<Data, AFError>) -> Int {
        switch dataResponse.result {
        case .failure, .success:
            return dataResponse.response?.statusCode ??
            (dataResponse.error?.underlyingError as NSError?)?.code ??
            (dataResponse.error as NSError?)?.code ??
            NSURLErrorNotConnectedToInternet
        }
    }
}
