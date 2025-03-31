//
//  OnboardingFlowController.swift
//  Eventistan
//
//  Created by Zain Najam Khan on 31/03/2025.
//

import Foundation
import UIKit

final class OnboardingFlowController: FlowController {
    override func startFlow() {
        let viewController = OnboardingPageViewBuilder.build(navigateToLogin: {
            [weak self] in
            self?.navigateToCitySelection()
        })
        rootNavigationController?.pushViewController(viewController, animated: true)

    }
}

extension OnboardingFlowController {
    func navigateToCitySelection() {
        let viewController = SelectCityBuilder.build(selectCityTapped: { [weak self] in
            self?.navigateToCityList()
        }, currentLocationTapped: {  [weak self] in
            self?.navigateToLogin()
        })
        rootNavigationController?.pushViewController(viewController, animated: true)
    }
    
    func navigateToCityList() {
        
    }
    
    func navigateToLogin() {
        
    }
}
