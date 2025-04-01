//
//  DependencyType.swift
//
//
//  Created by Zain Ul Abe Din on 08/10/2024.
//

import Foundation

public protocol DependencyType {
    var cacheStore: StoreType { get }
    var defaultStore: StoreType { get }
    var apiClient: APIClientType { get }
    var socketClient: SocketClientType { get }
    var tokenProvider: TokenProviderType { get }
    var userInfoProvider: UserInfoProviderType { get }
    var networkReachabilityMonitor: NetworkReachabilityMonitorType { get }
    var appInfoProvider: AppInfoProviderType { get }
}
