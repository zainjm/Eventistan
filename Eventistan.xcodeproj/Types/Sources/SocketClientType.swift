//
//  SocketClientType.swift
//  Types
//
//  Created by Zain Ul Abe Din on 21/01/2025.
//

import Foundation

public protocol SocketClientDelegate: AnyObject {
    func socketClientDidConnect(_ client: SocketClientType)
    func socketClientDidDisconnect(_ client: SocketClientType)
    func socketClient(_ client: SocketClientType, didReceiveError: [Any])
    func socketClient(_ client: SocketClientType, didStartSession session: [Any])
}

public extension SocketClientDelegate {
    func socketClientDidConnect(_ client: SocketClientType) { }
    func socketClientDidDisconnect(_ client: SocketClientType) { }
    func socketClient(_ client: SocketClientType, didReceiveError: [Any]) { }
    func socketClient(_ client: SocketClientType, didStartSession session: [Any]) { }
}

public protocol SocketClientType: AnyObject {
    var delegate: SocketClientDelegate? { get set }
    
    func start()
    func performRequest<T: Decodable>(
        with router: SocketRouterType,
        completion: @escaping (Result<T?, Error>) -> Void
    )
}
