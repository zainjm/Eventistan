//
//  NetworkReachabilityMonitor.swift
//  MicroFrontendKit
//
//  Created by Zain Ul Abe Din on 16/01/2025.
//

import Foundation
import Network
import Types
import Extensions

final class NetworkReachabilityMonitor {
    // MARK: - Properties
    private let monitor: NWPathMonitor
    private let monitorQueue = DispatchQueue(label: "network_monitoring")
    private var privousStatus: NWPath.Status?
    private var timer: Timer?
    var reachabilityStatus: NetworkReachabilityMonitorStatus = .connected {
        didSet {
            switch reachabilityStatus {
            case .disconnected:
                NotificationCenter.default.post(name: .internetConnectionLostNotification, object: nil)
            case .connected:
                NotificationCenter.default.post(name: .internetConnectionRecoveredNotification, object: nil)
            case .connecting:
                NotificationCenter.default.post(name: .internetConnectionRecoveringNotification, object: nil)
            }
        }
    }
    
    // MARK: - Initialization
    public init (monitor: NWPathMonitor = .init()) {
        self.monitor = monitor
    }
}

// MARK: - Monitoring
extension NetworkReachabilityMonitor: NetworkReachabilityMonitorType {
    func startMonitoring() {
        monitor.pathUpdateHandler = { [weak self] path in
            DispatchQueue.main.async {
                self?.handleNetworkStatus(path.status)
            }
        }
        monitor.start(queue: monitorQueue)
    }
    
    func stopMonitoring() {
        monitor.cancel()
    }
}

// MARK: - Utils
private extension NetworkReachabilityMonitor {
    func handleNetworkStatus(_ status: NWPath.Status) {
        if status == privousStatus {
            return
        }
        timer?.invalidate()
        
        let initilizedWithConnectedState = status == .satisfied && privousStatus == nil
        guard !initilizedWithConnectedState else { return }
        
        let disconnectedAfterConnecting = status == .unsatisfied && privousStatus == .requiresConnection
        
        if disconnectedAfterConnecting {
            timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: false, block: { [weak self] _ in
                self?.updatedStatus(status)
            })
            return
        }
        
        updatedStatus(status)
    }
    
    private func updatedStatus(_ status: NWPath.Status) {
        privousStatus = status
        switch status {
        case .requiresConnection: reachabilityStatus = .connecting
        case .satisfied: reachabilityStatus = .connected
        case .unsatisfied: reachabilityStatus = .disconnected
        @unknown default: break
        }
    }
}
