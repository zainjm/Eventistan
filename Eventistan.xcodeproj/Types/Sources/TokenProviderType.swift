//
//  TokenProviderType.swift
//
//
//  Created by Zain Ul Abe Din on 02/10/2024.
//

import Foundation

public struct TokenInfo: Codable {
    public let accessToken: String
    public let refreshToken: String
    public let idToken: String
    
    public init(accessToken: String, refreshToken: String, idToken: String) {
        self.accessToken = accessToken
        self.refreshToken = refreshToken
        self.idToken = idToken
    }
}

public protocol TokenProviderType {
    var tokenInfo: TokenInfo? { get }
    var bearerToken: String? { get }
    var basicToken: String? { get }
    var tokenCookie: String? { get }
    var expiresAt: Date? { get }
    
    func saveTokenInfo(_ tokenInfo: TokenInfo)
    func clearTokenInfo(refreshFailure: Bool)
}
