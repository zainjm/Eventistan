//
//  UIView+Ext.swift
//  
//
//  Created by Zain Ul Abe Din on 07/10/2024.
//

import Foundation
import UIKit
import Theme

public extension UIView {
    var frameInWindow: CGRect {
        self.superview?.convert(self.frame, to: nil) ?? .zero
    }
    
    var conatinsFirstResponder: Bool {
        let firstResponder: UIView? = findFirstReponder()
        return firstResponder != nil
    }
    
    class var reuseId: String {
        String(describing: Self.self)
    }
    
    class func loadFromNib<T: UIView>(_ bundle: Bundle = .main) -> T {
        let nibs = bundle.loadNibNamed(String(describing: T.self), owner: nil, options: nil)
        return nibs![0] as! T
    }
    
    func embedView(_ subview: UIView, insets: UIEdgeInsets = .zero) {
        subview.translatesAutoresizingMaskIntoConstraints = false
        addSubview(subview)
        NSLayoutConstraint.activate([
            subview.topAnchor.constraint(equalTo: topAnchor, constant: insets.top),
            subview.leadingAnchor.constraint(equalTo: leadingAnchor, constant: insets.left),
            subview.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -insets.bottom),
            subview.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -insets.right)])
    }
    
    func findSubview<T: UIView>() -> T? {
        if self is T {
            return self as? T
        }
        
        for subview in subviews {
            if let foundView: T = subview.findSubview() {
                return foundView
            }
        }
        
        return nil
    }
    
    func findFirstReponder<T: UIView>() -> T? {
        guard !self.isFirstResponder else { return self as? T }
        
        for subview in subviews {
            if let responder: T = subview.findFirstReponder() {
                return responder
            }
        }
        
        return nil
    }
    
    func applyGradient(colors: [UIColor], locations: [NSNumber]? = nil, startPoint: CGPoint = CGPoint(x: 0.5, y: 0), endPoint: CGPoint = CGPoint(x: 0.5, y: 1), transform: CATransform3D? = nil,  heightFraction: CGFloat = 1.0, bounds: CGRect? = nil, position: CGPoint? = nil, radius: CGFloat = 0) {
        layer.sublayers?.removeAll(where: { $0 is CAGradientLayer })
        
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = colors.map { $0.cgColor }
        gradientLayer.locations = locations
        gradientLayer.startPoint = startPoint
        gradientLayer.endPoint = endPoint
        
        if let bounds = bounds {
            let height = bounds.height * heightFraction
            gradientLayer.frame = CGRect(x: 0, y: 0, width: bounds.width, height: height)
        }
         if let transform = transform {
             gradientLayer.transform = transform
         }
         
         gradientLayer.frame = bounds ?? self.bounds
         if let position = position {
             gradientLayer.position = position
         }
         
        
        if radius != 0 {
            gradientLayer.maskedCorners = [.layerMaxXMaxYCorner,.layerMaxXMinYCorner,.layerMinXMaxYCorner,.layerMinXMinYCorner]
            gradientLayer.cornerCurve = .continuous
            gradientLayer.cornerRadius = radius
        }
        
        layer.insertSublayer(gradientLayer, at: 0)
    }
    
    
    func parentViewController() -> UIViewController? {
        if let nextResponder = self.next as? UIViewController {
            return nextResponder
        } else if let nextResponder = self.next as? UIView {
            return nextResponder.parentViewController()
        } else {
            return nil
        }
    }
    
    func setHighlightable(_ target: AnyObject, selector: Selector, withHightlightColor highlightColor: UIColor = .blue200) {
        let highlightableButton =  HighlightableButton()
        highlightableButton.hightlightColor = highlightColor
        embedView(highlightableButton)
        highlightableButton.layer.zPosition = 1_000
        highlightableButton.addTarget(target, action: selector, for: .touchUpInside)
    }

}

extension UIView {
    @objc
    open func configure(with viewModel: Any) {
        // An optional implementation.
        // Must be implemented if `viewModel` has to be configured.
        assertionFailure("configure(with viewModel: Any) needs to be overriden")
    }
}


private class HighlightableButton: UIButton {
    // MARK: - Constant
    private enum Constant {
        static let hightlightedAlpha: CGFloat = 0.5
        static let unhightlightedAlpha: CGFloat = .zero
    }
    
    // MARK: - Properties
    var hightlightColor: UIColor = .primary
    
    public override var isHighlighted: Bool {
        didSet { backgroundColor = hightlightColor.withAlphaComponent(isHighlighted ? Constant.hightlightedAlpha : Constant.unhightlightedAlpha) }
    }
}

public extension UIView {
    /// Animates the button's visibility based on its height.
    /// - Parameters:
    ///   - height: The current height of the button.
    ///   - threshold: The height threshold to show/hide the button.
    ///   - duration: The animation duration for the fade effect.
    func updateAlphaWithHeight(height: CGFloat, minHeight: CGFloat, maxHeight: CGFloat, duration: TimeInterval = 0.5, complitionHandler: ((Bool) -> Void)?) {
        let clampedHeight = max(minHeight, min(height, maxHeight))
        let alpha = (clampedHeight - minHeight) / (maxHeight - minHeight)
        UIView.animate(withDuration: duration) {
            self.alpha = alpha
        } completion: { complition in
            complitionHandler?(alpha == 0)
        }
    }
    
    
}

public extension UIView {
    
    func addTapEffect(scale: CGFloat = 0.95, duration: TimeInterval = 0.2) {
        self.isUserInteractionEnabled = true
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTapEffect))
        self.addGestureRecognizer(tapGesture)
        
        layer.setValue(scale, forKey: "tapEffectScale")
        layer.setValue(duration, forKey: "tapEffectDuration")
    }

    @objc private func handleTapEffect(_ gesture: UITapGestureRecognizer) {
        guard let scale = layer.value(forKey: "tapEffectScale") as? CGFloat,
              let duration = layer.value(forKey: "tapEffectDuration") as? TimeInterval else { return }

        UIView.animate(withDuration: duration / 2, animations: { [weak self] in
            self?.transform = CGAffineTransform(scaleX: scale, y: scale)
        }) { [weak self] _ in
            UIView.animate(withDuration: duration / 2) {
                self?.transform = .identity
            }
        }
    }
    
    func updateGradientLayerFrame(){
        let allSubLayers = layer.sublayers ?? []
        for sublayer in allSubLayers {
            if let gradientLayer = sublayer as? CAGradientLayer {
                gradientLayer.frame = bounds
                break
            }
        }
    }
}

// MARK: - Scale Effect Animation on Tap
/// Use `addScaleEffect(target:selector:)` on any UIView to add a scale animation on tap
public extension UIView {
    func addScaleEffect(target: AnyObject?, selector: Selector, scaleX: CGFloat = 0.95, scaleY: CGFloat = 0.95, animationDuration: TimeInterval = 0.2) {
        let tapGesture = UILongPressGestureRecognizer(target: self, action: #selector(handleTapGesture(_:)))
        tapGesture.minimumPressDuration = 0
        tapGesture.cancelsTouchesInView = false
        self.addGestureRecognizer(tapGesture)
        
        objc_setAssociatedObject(tapGesture, &AssociatedKeys.target, target, .OBJC_ASSOCIATION_ASSIGN)
        objc_setAssociatedObject(tapGesture, &AssociatedKeys.selector, selector, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        objc_setAssociatedObject(tapGesture, &AssociatedKeys.scaleX, scaleX, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        objc_setAssociatedObject(tapGesture, &AssociatedKeys.scaleY, scaleY, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        objc_setAssociatedObject(tapGesture, &AssociatedKeys.animationDuration, animationDuration, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
    }
    
    @objc private func handleTapGesture(_ gesture: UILongPressGestureRecognizer) {
        guard let scaleX = objc_getAssociatedObject(gesture, &AssociatedKeys.scaleX) as? CGFloat,
              let scaleY = objc_getAssociatedObject(gesture, &AssociatedKeys.scaleY) as? CGFloat,
              let duration = objc_getAssociatedObject(gesture, &AssociatedKeys.animationDuration) as? TimeInterval else { return }
        
        switch gesture.state {
        case .began:
            UIView.animate(withDuration: duration) {
                self.transform = CGAffineTransform(scaleX: scaleX, y: scaleY)
            }
        case .ended, .cancelled:
            UIView.animate(withDuration: duration) {
                self.transform = .identity
            }
            if let target = objc_getAssociatedObject(gesture, &AssociatedKeys.target) as? NSObject,
               let selector = objc_getAssociatedObject(gesture, &AssociatedKeys.selector) as? Selector {
                target.perform(selector, with: self)
            }
        default:
            break
        }
    }
    
    // MARK: - Associated Object Keys
    private struct AssociatedKeys {
        static var target: UInt8 = 0
        static var selector: UInt8 = 0
        static var scaleX: UInt8 = 0
        static var scaleY: UInt8 = 0
        static var animationDuration: UInt8 = 0
    }
}
