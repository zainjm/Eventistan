//
//  FlowController.swift
//  UIToolKit
//
//  Created by Zain Ul Abe Din on 20/11/2024.
//

import UIKit

protocol FlowControllerDelegate: AnyObject {
    func flowControllerDidFinish(_ flowController: FlowControllerType)
}

open class FlowController: NSObject {
    // MARK: - Properties
    public var rootNavigationController: UINavigationController?
    private(set) public var flowControllers = [FlowController]()
    private weak var flowControllerDelegate: (any FlowControllerDelegate)?
    public var flowControllerId: UUID = UUID()
    
    // MARK: - Initialization
    public required init(rootNavigationController: UINavigationController?) {
        self.rootNavigationController = rootNavigationController
    }
    
    // MARK: - Functions
    open func startFlow() { }
    
    public func navigate(to flowController: any FlowControllerType) {
        guard let flowController = flowController as? FlowController else { return }
        flowController.flowControllerDelegate = self
        flowControllers.append(flowController)
        flowController.startFlow()
    }
    
    public func finish() {
        flowControllerDelegate?.flowControllerDidFinish(self)
    }
}

// MARK: - Flow controller delegate
extension FlowController: FlowControllerDelegate {
    public func flowControllerDidFinish(_ flowController: FlowControllerType) {
        flowControllers.removeAll(where: { $0.flowControllerId == flowController.flowControllerId })
    }
}

extension FlowController: UIViewControllerTransitioningDelegate {
    public func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return CrossDissolveAnimator(isPresenting: false)
    }
    
    public func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> (any UIViewControllerAnimatedTransitioning)? {
        return CrossDissolveAnimator(isPresenting: true)
    }
}
