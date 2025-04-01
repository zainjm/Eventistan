//
//  NetworkingSessionProvider.swift
//
//
//  Created by Zain Ul Abe Din on 03/10/2024.
//

import Foundation
import Alamofire
import Types

protocol SessionProviderType {
    var apiClient: APIClientType { get set }
    
    func makeTrustedSession(for apiClient: APIClientType) -> Session
    func makeDefaultSession(for apiClient: APIClientType) -> Session
}

final class NetworkingSessionProvider {
    // MARK: - Properties
    let configuration: URLSessionConfiguration
    let securedKeyProvider: SecuredKeyProviderType
    let interceptor: InterceptorType
    let eventMonitor: NetworkEventMonitorType
    var apiClient: any APIClientType {
        get { interceptor.apiClient }
        set { interceptor.apiClient = newValue }
    }
    
    // MARK: - Initialization
    init(
        configuration: URLSessionConfiguration,
        securedKeyProvider: SecuredKeyProviderType,
        interceptor: InterceptorType,
        eventMonitor: NetworkEventMonitorType) {
        self.configuration = configuration
        self.securedKeyProvider = securedKeyProvider
        self.interceptor = interceptor
        self.eventMonitor = eventMonitor
    }
    
    convenience init(
        configuration: URLSessionConfiguration,
        securedKeyProvider: SecuredKeyProviderType,
        tokenProvider: TokenProviderType,
        eventMonitor: NetworkEventMonitorType,
        tracker: TrackerType
    ) {
        self.init(
            configuration: configuration,
            securedKeyProvider: securedKeyProvider,
            interceptor: Interceptor(
                tokenProvider: tokenProvider,
                tracker: tracker
            ),
            eventMonitor: eventMonitor
        )
    }
}

// MARK: - Session providing
extension NetworkingSessionProvider: SessionProviderType {
    func makeTrustedSession(for apiClient: APIClientType) -> Session {
        interceptor.apiClient = apiClient
        return Session(
            configuration: configuration,
            interceptor: interceptor,
            serverTrustManager: makeServerTrustManager(),
            eventMonitors: [eventMonitor]
        )
    }
    
    func makeDefaultSession(for apiClient: APIClientType) -> Session {
        interceptor.apiClient = apiClient
        return Session(
            configuration: configuration,
            interceptor: interceptor,
            eventMonitors: [eventMonitor]
        )
    }
}

// MARK: - Utility
private extension NetworkingSessionProvider {
    private func makeServerTrustManager() -> ServerTrustManager? {
        guard let secKeyInfo = securedKeyProvider.publicKeyInfo else { return nil }
        
        let serverTrustEvaluators = [
            secKeyInfo.hostName: PublicKeyHashEvaluator(secKeyInfo.publicKeyHashes)
        ]
        
        return ServerTrustManager(evaluators: serverTrustEvaluators)
    }
}
