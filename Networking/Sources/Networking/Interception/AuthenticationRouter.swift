//
//  NetworkingRouter.swift
//  Networking
//
//  Created by Zain Ul Abe Din on 11/11/2024.
//

import Foundation
import Types

private let authBaseUrl = Bundle.main.object(forInfoDictionaryKey: "AUTH_BASE_URL") as? String ?? ""
private let realm = Bundle.main.object(forInfoDictionaryKey: "AUTH_REALM") as? String ?? ""

enum AuthenticationRouter: NetworkRouterType {
    case refreshToken(refreshToken: String)
    
    var httpMethod: APPHTTPMethod {
        switch self {
        case .refreshToken: return .post
        }
    }
    
    var url: String {
        switch self {
        case .refreshToken:
            return "\(authBaseUrl)/auth/realms/\(realm)/protocol/openid-connect/token"
        }
    }
    
    var httpBody: Data? {
        switch self {
        case .refreshToken(refreshToken: let refreshToken):
            return "grant_type=refresh_token&refresh_token=\(refreshToken)&scope=open_id&client_id=frontend"
                .data(using: .utf8)
        }
    }
    
    var contentType: ContentType {
        switch self {
        case .refreshToken: return .xwwwFormURLEncoded
        }
    }
    
    var authorization: AuthorizationType {
        switch self {
        case .refreshToken: return .none
        }
    }
    
    func asUrlRequest() -> URLRequest {
       let asURL = URL(string: url)!
       var urlRequest = URLRequest(url: asURL)
       urlRequest.httpMethod = httpMethod.rawValue
       urlRequest.httpBody = httpBody
       return urlRequest
   }
}
