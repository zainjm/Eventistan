//
//  CrossDissolveAnimator.swift
//  UIToolKit
//
//  Created by Zain Ul Abe Din on 08/01/2025.
//

import UIKit

final class CrossDissolveAnimator: NSObject, UIViewControllerAnimatedTransitioning {
    // MARK: Properties
    private var isPresenting: Bool
    
    // MARK: - Constants
    private enum Constant {
        static let animationDuration: TimeInterval = 0.5
        static let clear: CGFloat = 0.0
        static let opaque: CGFloat = 1.0
    }
    
    // MARK: - Initializer
    init(isPresenting: Bool) {
        self.isPresenting = isPresenting
    }
    
    // MARK: Functions
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        Constant.animationDuration
    }

    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        guard let targetView = transitionContext.view(forKey: isPresenting ? .to : .from) else {
            transitionContext.completeTransition(false)
            return
        }
        
        let containerView = transitionContext.containerView
        containerView.addSubview(targetView)

        targetView.alpha = isPresenting ? Constant.clear : Constant.opaque
        UIView.animate(withDuration: transitionDuration(using: transitionContext), animations: { [weak self, weak targetView] in
            targetView?.alpha = self?.isPresenting ?? false ? Constant.opaque: Constant.clear
        }) { [weak transitionContext] finished in
            transitionContext?.completeTransition(finished)
        }
    }
}
