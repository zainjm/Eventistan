//
//  ViewController.swift
//  Eventistan
//
//  Created by Zain Najam Khan on 24/03/2025.
//

import UIKit

final class AppFlowController {
    private let navigationController: UINavigationController

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func startFlow() {
        startLaunchScreen()
    }
}

extension AppFlowController {
    func startLaunchScreen() {
        let viewController = SplashBuilder.build(dependency: dependency) { [weak self] action in
            switch action {
            case .animationCompleted:
                self?.startDashboard()
            }
        }
        
        rootNavigationController?.setViewControllers([viewController], animated: false)
    }
    
    func startDashboard() {
        let flowController = DashboardFlowController(rootNavigationController: rootNavigationController)
        navigate(to: flowController)
    }
}
