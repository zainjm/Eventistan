//
//  LoggerUI.swift
//  Networking
//
//  Created by Zain Ul Abe Din on 06/01/2025.
//

import UIKit
import PulseUI
import SwiftUI

final class NetworkMonitorUI: NSObject {
    // MARK: - Properties
    private var window: UIWindow?
    private var isShowinConsole = false
    
    // MARK: - Initialization
    override init() {
        super.init()
        NotificationCenter.default.addObserver(self, selector: #selector(showConsole), name: Notification.Name("deviceDidShake"), object: nil)
    }
    
    // MARK: - APIs
    static func monitor() -> NetworkMonitorUI {
        UIWindow.swizzleMotionEnded()
        return NetworkMonitorUI()
    }
    
    func stop() {
        UIWindow.unswizzleMotionEnded()
        NotificationCenter.default.removeObserver(self)
    }
}

// MARK: - Utils
private extension NetworkMonitorUI {
    @objc func showConsole() {
        guard !isShowinConsole,
              let topViewController = UIApplication.topViewController()
        else { return }
        
        isShowinConsole = true
        
        let consoleHostingViewController = UIHostingController(rootView: ConsoleView())
        consoleHostingViewController.extendedLayoutIncludesOpaqueBars = true
        let navigationController = UINavigationController(rootViewController: consoleHostingViewController)
        navigationController.presentationController?.delegate = self
        topViewController.present(navigationController, animated: true)
    }
}

// MARK: - Sheet presentation delegate
extension NetworkMonitorUI: UISheetPresentationControllerDelegate {
    func presentationControllerDidDismiss(_ presentationController: UIPresentationController) {
        isShowinConsole = false
    }
}

// MARK: - Method swizzling
extension UIWindow {
    static func swizzleMotionEnded() {
        let originalSelector = #selector(motionEnded(_:with:))
        let swizzledSelector = #selector(swizzled_motionEnded(_:with:))
        
        if let originalMethod = class_getInstanceMethod(UIWindow.self, originalSelector),
           let swizzledMethod = class_getInstanceMethod(UIWindow.self, swizzledSelector) {
            method_exchangeImplementations(originalMethod, swizzledMethod)
        }
    }
    
    static func unswizzleMotionEnded() {
        let originalSelector = #selector(motionEnded(_:with:))
        let swizzledSelector = #selector(swizzled_motionEnded(_:with:))
        
        if let originalMethod = class_getInstanceMethod(UIWindow.self, originalSelector),
           let swizzledMethod = class_getInstanceMethod(UIWindow.self, swizzledSelector) {
            method_exchangeImplementations(swizzledMethod, originalMethod)
        }
    }
    
    @objc func swizzled_motionEnded(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
        if motion == .motionShake {
            NotificationCenter.default.post(name: Notification.Name("deviceDidShake"), object: nil)
        }
    }
}

// MARK: - Application extension to get top most view controller
extension UIApplication {
    class func topViewController(
        base: UIViewController? = UIApplication.shared.connectedScenes
            .filter { $0.activationState == .foregroundActive }
            .compactMap { $0 as? UIWindowScene }
            .first?.windows
            .first { $0.isKeyWindow }?.rootViewController
    ) -> UIViewController? {
        if let nav = base as? UINavigationController {
            return topViewController(base: nav.visibleViewController)
        } else if let tab = base as? UITabBarController {
            if let selected = tab.selectedViewController {
                return topViewController(base: selected)
            }
        } else if let presented = base?.presentedViewController {
            return topViewController(base: presented)
        }
        return base
    }
}
