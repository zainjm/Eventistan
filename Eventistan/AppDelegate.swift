//
//  AppDelegate.swift
//  Eventistan
//
//  Created by Zain Najam Khan on 24/03/2025.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    var appFlowController: AppFlowController?

    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {

        let navController = UINavigationController()
        appFlowController = AppFlowController(navigationController: navController)
        appFlowController?.start()

        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = navController
        window?.makeKeyAndVisible()

        return true
    }
}

