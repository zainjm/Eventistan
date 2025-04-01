//
//  AlamofireConvertible.swift
//
//
//  Created by Zain Ul Abe Din on 03/10/2024.
//

import Foundation
import Alamofire
import Types

final class NetworkingConvertible {
    // MARK: - Properties
    let router: NetworkRouterType
    let tokenProvider: TokenProviderType
    
    // MARK: - Initialization
    init(router: NetworkRouterType, tokenProvider: TokenProviderType) {
        self.router = router
        self.tokenProvider = tokenProvider
    }
}

extension NetworkingConvertible: URLRequestConvertible {
    func asURLRequest() throws -> URLRequest {
        var request = router.asUrlRequest()
        request.addValue(router.contentType.rawValue, forHTTPHeaderField: HeaderField.contentType.rawValue)
        switch router.authorization {
        case .basic:
            if let token = tokenProvider.basicToken {
                request.setValue(token, forHTTPHeaderField: HeaderField.authorization.rawValue)
            }
        case .bearer:
            if let token = tokenProvider.bearerToken {
                request.setValue(token, forHTTPHeaderField: HeaderField.authorization.rawValue)
            }
        case .cookie:
            if let token = tokenProvider.tokenCookie {
                request.setValue(token, forHTTPHeaderField: HeaderField.cookie.rawValue)
            }
        case .none: break
        }
        return request
    }
}
