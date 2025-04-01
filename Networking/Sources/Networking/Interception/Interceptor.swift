//
//  Interceptor.swift
//
//
//  Created by Zain Ul Abe Din on 02/10/2024.
//

import Foundation
import Alamofire
import Types

public protocol InterceptorType: AnyObject, RequestInterceptor {
    var apiClient: APIClientType! { get set }
}

final class Interceptor {
    // MARK: - Aliases
    private typealias RefreshCompletionHandler = (Result<TokenInfo, Error>) -> Void
    
    // MARK: - Properties
    weak var apiClient: APIClientType!
    private let tokenProvider: TokenProviderType
    private var isRefreshing: Bool = false
    private var retryCompletions: [(RetryResult) -> Void] = []
    private let tracker: TrackerType
    
    // MARK: - Constants
    private enum Constant {
        static let unauthorizedCode = 401
        static let humbuckerHeader = "Www-Authenticate"
        static let humbuckerChallenges = ["hb-challenge", "hb-captcha", "hb-login", "hb-appAttestation"]
        static let name = "name"
        static let value = "value"
        static let reason = "reason"
    }
    
    // MARK: Initialization
    init(tokenProvider: TokenProviderType, tracker: TrackerType) {
        self.tokenProvider = tokenProvider
        self.tracker = tracker
    }
}

// MARK: - Interception
extension Interceptor: InterceptorType {
    func retry(_ request: Request, for session: Session, dueTo error: any Error, completion: @escaping (RetryResult) -> Void) {
        guard let response = request.response,
              response.statusCode == Constant.unauthorizedCode,
              tokenProvider.tokenInfo != nil,
              let url = request.request?.url,
              url.absoluteString != AuthenticationRouter.refreshToken(refreshToken: "").url,
              response.headers.value(for: Constant.humbuckerHeader)?.components(separatedBy: ", ").filter({ Constant.humbuckerChallenges.contains($0) }).isEmpty ?? false
        else { return completion(.doNotRetryWithError(error)) }
        retryCompletions.append(completion)
        
        guard !isRefreshing else { return }
        trackRefreshEvent(eventName: .refreshStart)
        isRefreshing = true
        
        refreshToken { [weak self] result in
            switch result {
            case .success(let token):
                DispatchQueue.main.sync { [weak self] in
                    self?.trackRefreshEvent(eventName: .refreshSuccess)
                    self?.tokenProvider.saveTokenInfo(token)
                }
                self?.retryCompletions.forEach({ $0(.retry) })
            case .failure(let error):
                debugPrint("ERROR refreshing token: \(error)")
                self?.trackRefreshEvent(eventName: .refreshFailure, errorCode: error.asAFError?.responseCode)
                if let errorCode = error.asAFError?.responseCode,
                   !CommonConstants.unAuthCodes.contains(errorCode)
                { return }
                self?.tokenProvider.clearTokenInfo(refreshFailure: true)
                self?.retryCompletions.forEach({ $0(.doNotRetryWithError(error)) })
            }
            self?.isRefreshing = false
        }
    }
}

// MARK: - Utility
extension Interceptor {
    private func refreshToken(with completionHandler: @escaping RefreshCompletionHandler) {
        guard let refreshToken = tokenProvider.tokenInfo?.refreshToken else {
            completionHandler(.failure(NetworkingError.refreshTokenNotAvailable))
            return
        }
        Task { [weak self] in
            let route = AuthenticationRouter.refreshToken(refreshToken: refreshToken)
            let result: Result<RefreshTokenResponse, APIFailure>? = await self?.apiClient.performRequest(route: route)
            switch result {
            case .success(let response):
                completionHandler(.success(TokenInfo(accessToken: response.accessToken, refreshToken: response.refreshToken, idToken: response.idToken)))
            case .failure(let error):
                completionHandler(.failure(error))
            case .none:
                completionHandler(.failure(NetworkingError.tokenRefreshFailed))
            }
        }
    }
}

private extension Interceptor {
    func trackRefreshEvent(eventName: EventName, errorCode: Int? = nil) {
        var params = [String : String]()
        if let errorCode {
            let failureReason: FailureReason = CommonConstants.unAuthCodes.contains(errorCode) ? .expired : CommonConstants.errorCodes.contains(errorCode) ? .serverError : .noInternet
            params[Constant.name] = Constant.reason
            params[Constant.reason] = failureReason.rawValue
        }
        tracker.track(eventType: .event(name: eventName.rawValue, params: params))
    }
    
    enum EventName: String {
        case refreshStart = "refresh_start"
        case refreshSuccess = "refresh_success"
        case refreshFailure = "refresh_failure"
    }
    
    enum FailureReason: String {
        case serverError = "SERVER_ERROR"
        case noInternet = "NO_INTERNET"
        case expired = "EXPIRED"
    }
}
