//
//  FlowControllerType.swift
//  Eventistan
//
//  Created by Zain Najam Khan on 30/03/2025.
//

import Foundation
import UIKit
import Types

public protocol FlowControllerType: AnyObject {
    var flowControllerId: UUID { get }
    init(rootNavigationController: UINavigationController?, dependency: DependencyType)

    func startFlow()
    func navigate(to flowController: FlowControllerType)
}

// MARK: - Optional implementation
public extension FlowControllerType {
    func navigate(to flowController: FlowControllerType) { }
}

public protocol DeeplinkFlowControllerType: FlowControllerType {
    func handle(deeplink: URL) -> Bool
}
