//
//  GettingStartedBuilder.swift
//  Eventistan
//
//  Created by Zain Najam Khan on 30/03/2025.
//

import Foundation
class GettingStartedBuilder {
    class func build(infoType: InfoType, isFirstPage: Bool, onTapCallback: (() -> Void)?) -> GettingStartedViewController {
        let vc = GettingStartedViewController.instantiateViewController(from: .main)
        let viewModel = GettingStartedViewModel(infoType, isFirstPage: isFirstPage)
        viewModel.tapCallback = onTapCallback
        vc.viewModel = viewModel
        return vc
    }
}
