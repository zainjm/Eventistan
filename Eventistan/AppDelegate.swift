//
//  AppDelegate.swift
//  Eventistan
//
//  Created by Zain Najam Khan on 24/03/2025.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    lazy var window: UIWindow? = UIWindow()
    lazy var navigationController = UINavigationController()
    lazy var dependency = Dependency()
    lazy var appFlowController = AppFlowController(
        rootNavigationController: navigationController, dependency: dependency)

    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {
        navigationController.setNavigationBarHidden(true, animated: false)
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
        appFlowController.startFlow()
        return true
    }
}

