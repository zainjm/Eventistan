//
//  DashboardBuilder.swift
//  PK
//
//  Created by Zain Ul Abe Din on 06/11/2024.
//

import UIKit

final class DashboardBuilder {
    class func build() -> UIViewController {
        let viewModel = DashboardViewModel(actionHandler: nil)
        let viewController = DashboardViewController()
        viewController.viewModel = viewModel
        return viewController
    }
}
