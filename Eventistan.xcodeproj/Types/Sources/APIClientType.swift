//
//  APIClientType.swift
//
//
//  Created by Zain Ul Abe Din on 02/10/2024.
//

import Foundation

public protocol APIClientType: AnyObject {
    func performRequest(
        route: NetworkRouterType
    ) async -> Result<APISuccess, APIFailure>
    
    func performRequest<T: Decodable>(
        route: NetworkRouterType
    ) async -> Result<T, APIFailure>
    
    func startMonitoring()
    func stopMonitoring()
}
