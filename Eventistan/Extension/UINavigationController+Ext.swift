//
//  UINavigationController+Ext.swift
//  Extensions
//
//  Created by Mehnoor on 31/10/2024.
//

import UIKit

public extension UINavigationController {
    func topPresentedNavigationController<T: UIViewController>(for rootViewControllerType: T.Type) -> UINavigationController? {
        guard let presentedNavigationController = presentedViewController as? UINavigationController else {
            return nil
        }
        
        if ((presentedNavigationController.viewControllers.first as? T) != nil) {
            return presentedNavigationController
        }
        return presentedNavigationController.topPresentedNavigationController(for: rootViewControllerType)
    }

    func popToScreen<T: UIViewController>(ofType type: T.Type, animated: Bool, completion: ((T) -> Void)? = nil) {
        if let targetViewController = self.viewControllers.first(where: { $0 is T }) as? T {
            self.popToViewController(targetViewController, animated: animated)
            completion?(targetViewController)
        }
    }
    
    func setViewControllers(with animation: CATransitionType, _ viewControllers: [UIViewController], duration: TimeInterval = 0.3, completion: (() -> Void)? = nil) {
        CATransaction.begin()
        CATransaction.setCompletionBlock(completion)
        let transition = CATransition()
        transition.type = animation
        transition.duration = duration
        self.view.layer.add(transition, forKey: kCATransition)
        self.setViewControllers(viewControllers, animated: false)
        CATransaction.commit()
    }
}
