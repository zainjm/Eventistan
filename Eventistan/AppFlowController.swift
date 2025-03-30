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

    func start() {
        showHome()
    }

    private func showHome() {
        let homeVC = LoginBuilder.build()
        navigationController.setViewControllers([homeVC], animated: false)
    }
}
