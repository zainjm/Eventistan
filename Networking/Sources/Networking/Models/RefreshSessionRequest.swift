//
//  RefreshSessionRequest.swift
//  Networking
//
//  Created by Zain Ul Abe Din on 22/01/2025.
//

import Foundation

struct RefreshSessionRequest: Encodable {
    let accessToken: String
    let idToken: String
}
