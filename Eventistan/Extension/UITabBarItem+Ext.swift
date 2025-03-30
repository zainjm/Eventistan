//
//  UITabBarItem+Ext.swift
//  Extensions
//
//  Created by Zain Ul Abe Din on 15/01/2025.
//

import UIKit


public extension UITabBarItem {
    // MARK: - Constants
    private enum Constant {
        static let badgeTag = 0xdead
        static let viewKey = "view"
        static let badgeSize: CGFloat = 6
        static let iconSize: CGFloat = 30
        static let animationDuration: TimeInterval = 0.8
        static let springDamping: CGFloat = 0.325
        static let springVelocity: CGFloat = 1.0
    }
    
    // MARK: - Properties
    var isBadgeIndicatorHidden: Bool {
        get {
            self.view?.subviews.contains(where: { $0.tag == Constant.badgeTag }) ?? false
        }
        set { newValue ? hideBadge() : showBadge() }
    }
    
    var view: UIView? {
        guard let view = self.value(forKey: Constant.viewKey) as? UIView else {
            return nil
        }
     return view
    }
}

// MARK: - Badging
private extension UITabBarItem {
    func showBadge() {
        guard let itemView = self.view,
              !itemView.subviews.contains(where: { $0.tag == Constant.badgeTag })
        else { return }
        
        let badge = UIView(frame: CGRect(
            origin:
                CGPoint(x: ((itemView.bounds.width + Constant.iconSize) / 2) - 2, y: .extraSmall),
            size: CGSize(width: Constant.badgeSize, height: Constant.badgeSize))
        )
        badge.tag = Constant.badgeTag
        badge.round(corners: .allCorners, with: Constant.badgeSize / 2)
        itemView.addSubview(badge)
        
        badge.transform = CGAffineTransform(scaleX: .zero, y: .zero)
        UIView.animate(
            withDuration: Constant.animationDuration,
            delay: .zero,
            usingSpringWithDamping: Constant.springDamping,
            initialSpringVelocity: Constant.springVelocity,
            options: .curveEaseInOut,
            animations: { [weak badge] in
                badge?.transform = .identity
            }
        )
    }
    
    func hideBadge() {
        guard let itemView = self.view else { return }
        itemView.subviews.filter({ $0.tag == Constant.badgeTag }).forEach({ $0.removeFromSuperview() })
    }
}
