//
//  TokenProvider.swift
//  MotorsScaffold
//
//  Created by Zain Ul Abe Din on 09/10/2024.
//

import Foundation
import Types
import Extensions

final class TokenProvider: TokenProviderType {
    // MARK: - Properties
    private(set) var tokenInfo: TokenInfo? {
        didSet { notifyTokenChange() }
    }
    private(set) var bearerToken: String?
    private(set) var basicToken: String?
    private(set) var tokenCookie: String?
    var expiresAt: Date? {
        return ((tokenInfo?.accessToken).map({ JWTDecoder.decode(jwtToken: $0) })?["exp"] as? TimeInterval).map({ Date(timeIntervalSince1970: $0) })
    }
    private let store: StoreType
    private let notificationCenter: NotificationCenter
    
    // MARK: - Constants
    private enum Constant {
        static let tokenInfoKey = "AUTH_TOKEN_INFO"
        static let bearerTokenFormat = "Bearer %@"
        static let basicTokenFormat = "Basic %@"
        static let tokenCookieFormat = "kc_access_token=%@;kc_refresh_token=%@;kc_id_token=%@"
        static let elasticTokenKey = "ELASTIC_TOKEN"
    }
    
    // MARK: - Initialization
    init(
        with store: StoreType,
        notificationCenter: NotificationCenter = .default
    ) {
        self.store = store
        self.notificationCenter = notificationCenter
        readTokenInfo()
    }
    
    func saveTokenInfo(_ tokenInfo: TokenInfo) {
        try? store.save(data: tokenInfo, for: Constant.tokenInfoKey)
        updateInfo(with: tokenInfo)
    }
    
    func clearTokenInfo(refreshFailure: Bool) {
        try? store.deleteData(for: Constant.tokenInfoKey)
        self.tokenInfo = nil
        notifyUserLoggedOut(refreshFailure: refreshFailure)
    }
}

// MARK: - Utils
private extension TokenProvider {
    func updateInfo(with tokenInfo: TokenInfo) {
        let isFirstLogin = self.tokenInfo.isNil
        self.tokenInfo = tokenInfo
        bearerToken = String(
            format: Constant.bearerTokenFormat,
            tokenInfo.accessToken
        )
        tokenCookie = String(
            format: Constant.tokenCookieFormat,
            tokenInfo.accessToken,
            tokenInfo.refreshToken,
            tokenInfo.idToken
        )
        
        if isFirstLogin {
             notifyUserLoggedIn()
         }
    }
    
    func readTokenInfo() {
        if let elasticToken = Bundle.main.object(forInfoDictionaryKey: Constant.elasticTokenKey) as? String {
            basicToken = String(
                format: Constant.basicTokenFormat,
                elasticToken
            )
        }
        
        if let tokenInfo: TokenInfo = try? store.data(for: Constant.tokenInfoKey) {
            updateInfo(with: tokenInfo)
        }
    }
}

// MARK: - Notify
private extension TokenProvider {
    func notifyTokenChange() {
        notificationCenter.post(name: .tokenInfoDidChangeNotification, object: nil)
    }
    
    func notifyUserLoggedIn() {
        notificationCenter.post(name: .userDidLoginNotification, object: nil)
    }
    
    func notifyUserLoggedOut(refreshFailure: Bool) {
        notificationCenter.post(name: .userDidLogoutNotification, object: nil, userInfo: [CommonConstants.refreshFailure: refreshFailure])
    }
}
