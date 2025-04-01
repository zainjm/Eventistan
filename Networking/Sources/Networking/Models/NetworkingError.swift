//
//  NetworkingError.swift
//
//
//  Created by Zain Ul Abe Din on 02/10/2024.
//

import Foundation

public enum NetworkingError: Error {
    case basicTokenNotAvailable
    case bearerTokenNotAvailable
    case refreshTokenNotAvailable
    case tokenRefreshFailed
    case cookieNotAvailable
    case socketNotConnected
    case generic
}
