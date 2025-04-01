//
//  CornerRadius.swift
//
//
//  Created by Zain Ul Abe Din on 03/10/2024.
//

import UIKit

// MARK: - Corner radius
public enum CornerRadius: CGFloat {
    case extraSmall = 4
    case small = 6
    case mediumLow = 8
    case medium = 12
    case large = 16
    case extraLarge = 20
    case doubleExtraLarge = 24
}

// MARK: - UIView + Corner radius
public extension UIView {
    var cornerRadius: CornerRadius? {
        get { CornerRadius(rawValue: layer.cornerRadius) }
        set { setCornerRadius(newValue?.rawValue ?? .zero) }
    }
    
    func round(corners: UIRectCorner, with cornerRadius: CornerRadius) {
        layer.maskedCorners = corners.cornerMask
        setCornerRadius(cornerRadius.rawValue)
    }
    
    func round(corners: UIRectCorner, with cornerRadius: CGFloat) {
        layer.maskedCorners = corners.cornerMask
        setCornerRadius(cornerRadius)
    }
    
    func round() {
        self.layer.cornerRadius = self.frame.size.height/2
        self.clipsToBounds = true
    }
    
    private func setCornerRadius(_ radius: CGFloat) {
        layer.cornerRadius = radius
        layer.masksToBounds = radius != .zero
    }
}

private extension UIRectCorner {
    var cornerMask: CACornerMask {
        guard !contains(.allCorners) else {
            return [
                .layerMinXMinYCorner,
                .layerMaxXMinYCorner,
                .layerMinXMaxYCorner,
                .layerMaxXMaxYCorner
            ]
        }
        
        var cornerMask: CACornerMask = []
        
        if self.contains(.topLeft) {
            cornerMask.insert(.layerMinXMinYCorner)
        }
        if self.contains(.topRight) {
            cornerMask.insert(.layerMaxXMinYCorner)
        }
        if self.contains(.bottomLeft) {
            cornerMask.insert(.layerMinXMaxYCorner)
        }
        if self.contains(.bottomRight) {
            cornerMask.insert(.layerMaxXMaxYCorner)
        }
        
        return cornerMask
    }
}
