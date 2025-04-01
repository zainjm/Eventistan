//
//  NetworkReachabilityMonitorType.swift
//  Types
//
//  Created by Zain Ul Abe Din on 16/01/2025.
//

public enum NetworkReachabilityMonitorStatus {
    case disconnected
    case connected
    case connecting
}

public protocol NetworkReachabilityMonitorType {
    var reachabilityStatus: NetworkReachabilityMonitorStatus { get }
    
    func startMonitoring()
    func stopMonitoring()
}
