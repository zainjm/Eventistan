//
//  ViewController.swift
//  Eventistan
//
//  Created by Zain Najam Khan on 24/03/2025.
//

import UIKit

final class AppFlowController: FlowController {
    // MARK: - Flow
    override func startFlow() {
        startSplash()
    }
}

// MARK: - Flow
private extension AppFlowController {
    func startSplash() {
        let viewController = SplashBuilder.build() { [weak self] action in
            switch action {
            case .animationCompleted:
                self?.startDashboard()
            }
        }
        
        rootNavigationController?.setViewControllers([viewController], animated: false)
    }
    
    func startDashboard() {
        let flowController = DashboardFlowController(rootNavigationController: rootNavigationController, dependency: dependency)
        navigate(to: flowController)
    }
}
