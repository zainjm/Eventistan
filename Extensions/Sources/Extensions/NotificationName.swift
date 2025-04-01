//
//  File.swift
//  Extensions
//
//  Created by Zain Najam Khan on 02/04/2025.
//

import Foundation

public extension Notification.Name {
    static let tokenInfoDidChangeNotification = Notification.Name("tokenInfoDidChangeNotification")
    static let internetConnectionLostNotification = Notification.Name("internetConnectionLostNotification")
    static let internetConnectionRecoveringNotification = Notification.Name("internetConnectionRecoveringNotification")
    static let internetConnectionRecoveredNotification = Notification.Name("internetConnectionRecoveredNotification")
    static let userDidLoginNotification = Notification.Name("userDidLoginNotification")
    static let userDidLogoutNotification = Notification.Name("userDidLogoutNotification")
    static let adPostedNotification = Notification.Name("AD_POSTED_NOTIFICATION")
}
