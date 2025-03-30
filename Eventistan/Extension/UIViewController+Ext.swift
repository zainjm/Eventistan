//
//  UIViewController+Ext.swift
//  
//
//  Created by Zain Ul Abe Din on 16/10/2024.
//

import UIKit

// MARK: - Initialization
public extension UIViewController {
    static func instantiateViewController(from bundle: Bundle) -> Self {
        create(from: UIStoryboard(name: storyboardName, bundle: bundle),
               with: identifier)
    }
}

private extension UIViewController {
    static var identifier: String {
        String(describing: self)
    }

    static var storyboardName: String {
        String(describing: self)
    }

    static func create<T>(
        from storyboard: UIStoryboard,
        with identifier: String
    ) -> T {
        storyboard.instantiateViewController(withIdentifier: identifier) as! T
    }
}

// MARK: - Alert
public typealias SimpleAlertAction = (title: String, actionHandler: (() ->Void)?)
public typealias SimpleSheetAction = (title: String, style: UIAlertAction.Style, actionHandler: (() ->Void)?)

public extension UIViewController {
    func showSimpleAlert(
        with title: String? = nil,
        description: String? = nil,
        actions: SimpleAlertAction...
    ) {
        let alertController = UIAlertController(
            title: title,
            message: description,
            preferredStyle: .alert
        )
        
        for action in actions {
            let alertAction = UIAlertAction(title: action.title, style: .default) { _ in
                action.actionHandler?()
            }
            alertController.addAction(alertAction)
        }
        
        (presentedViewController ?? self).present(alertController, animated: true)
    }
    
    func showSimpleAlert(
        with title: String? = nil,
        description: String? = nil,
        actions: SimpleSheetAction...
    ) {
        let alertController = UIAlertController(
            title: title,
            message: description,
            preferredStyle: .alert
        )
        
        for action in actions {
            let alertAction = UIAlertAction(title: action.title, style: action.style) { _ in
                action.actionHandler?()
            }
            alertController.addAction(alertAction)
        }
        
        (presentedViewController ?? self).present(alertController, animated: true)
    }
    
    func showSimpleActionsheet(
        with title: String? = nil,
        description: String? = nil,
        actions: SimpleSheetAction...
    ) {
        showSimpleActionsheet(with: title, description: description, actions: actions)
    }
    
    func showSimpleActionsheet(
        with title: String? = nil,
        description: String? = nil,
        actions: [SimpleSheetAction]
    ) {
        let alertController = UIAlertController(
            title: title,
            message: description,
            preferredStyle: .actionSheet
        )
        
        for action in actions {
            let alertAction = UIAlertAction(title: action.title, style: action.style) { _ in
                action.actionHandler?()
            }
            alertController.addAction(alertAction)
        }
        
        (presentedViewController ??     self).present(alertController, animated: true)
    }
    
    func setTopViews(stackView: UIStackView, imageView: UIImageView, icon: String, label: UILabel, title: String, isSelected: Bool = false) {
        stackView.backgroundColor = isSelected ? .grey6 : .background
        stackView.cornerRadius = .small
        stackView.borderColor = isSelected ? .clear : .grey2
        stackView.border = .light
        if isSelected {
            stackView.applyDropShadow(shadowRadius: 4, shadowOpacity: 0.05)
        }
        imageView.image = UIImage(named: icon)
        label.font = .paragraph8
        label.textColor = isSelected ? .background : .grey6
        label.text = title
    }
    
    func setInteractivePopEnabled( _ enabled: Bool) {
        navigationController?.interactivePopGestureRecognizer?.isEnabled = enabled
        navigationController?.interactivePopGestureRecognizer?.delegate = enabled ? self : nil
    }
}

extension UIViewController: UIGestureRecognizerDelegate {
    public func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        if gestureRecognizer == self.navigationController?.interactivePopGestureRecognizer {
            return (navigationController?.viewControllers.count ?? .zero) > 1
        }
        return true
    }
}
