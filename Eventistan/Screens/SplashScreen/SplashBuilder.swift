//
//  SplashBuilder.swift
//  App
//
//  Created by Zain Ul Abe Din on 20/02/2025.
//

import UIKit

final class SplashBuilder {
    class func build(actionHandler: SplashActionHandler?) -> UIViewController {
        let viewModel = SplashViewModel(actionHandler: actionHandler)
        let viewController = SplashViewController.instantiateViewController(from: .main)
        viewController.viewModel = viewModel
        return viewController
    }
}
