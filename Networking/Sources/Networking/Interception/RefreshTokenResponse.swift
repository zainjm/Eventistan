//
//  RefreshTokenResponse.swift
//  Networking
//
//  Created by Zain Ul Abe Din on 11/11/2024.
//

struct RefreshTokenResponse: Decodable {
    let accessToken: String
    let expiresIn: Int
    let refreshToken: String
    let tokenType: String
    let idToken: String
    
    private enum CodingKeys: String, CodingKey {
        case accessToken = "access_token"
        case expiresIn = "refresh_expires_in"
        case refreshToken = "refresh_token"
        case tokenType = "token_type"
        case idToken = "id_token"
    }
}
