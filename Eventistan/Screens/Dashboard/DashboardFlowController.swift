//
//  DashboardFlowController.swift
//  Eventistan
//
//  Created by Zain Najam Khan on 30/03/2025.
//

import Foundation
import UIKit

final class DashboardFlowController: FlowController {
    // MARK: - Properties
    private var nextFlowController: FlowControllerType!
    
    // MARK: - Initialization
    required init(
        rootNavigationController: UINavigationController?) {
        super.init(rootNavigationController: rootNavigationController)
    }
    
    // MARK: - Flow
    override func startFlow() {
        let viewController = SplashBuilder.build(actionHandler: { [weak self] action in
            switch action {
            case .animationCompleted:
                self?.startOnboarding()
            }
        })
        rootNavigationController?.setViewControllers(with: .fade, [viewController])
    }
}

extension DashboardFlowController {
    func startOnboarding() {
        
        let flowController = OnboardingFlowController(rootNavigationController: rootNavigationController)
        navigate(to: flowController)
    }
    
    func navigateToCitySelection() {
        
    }
}
