//
//  FlowControllerType.swift
//
//
//  Created by Zain Ul Abe Din on 08/10/2024.
//

import Foundation
import UIKit

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
