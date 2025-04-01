//
//  SocketRouterType.swift
//  Types
//
//  Created by Zain Ul Abe Din on 21/01/2025.
//

import Foundation

public protocol SocketRouterType {
    var event: String { get }
    var request: Encodable? { get }
    var keepsObserving: Bool { get }
}

public extension SocketRouterType {
    var keepsObserving: Bool { return false }
}
