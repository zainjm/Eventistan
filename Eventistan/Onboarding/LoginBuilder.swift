//
//  LoginBuilder.swift
//  Eventistan
//
//  Created by Zain Najam Khan on 30/03/2025.
//

import Foundation
import UIKit

final class LoginBuilder {
    class func build() -> UIViewController {
        let viewModel = LoginViewModel()
        let viewController = LoginViewController.instantiateViewController(from: .main)
        viewController.viewModel = viewModel
        return viewController
    }
}
