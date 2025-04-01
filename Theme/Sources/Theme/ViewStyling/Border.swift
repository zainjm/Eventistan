//
//  Border.swift
//
//
//  Created by Zain Ul Abe Din on 03/10/2024.
//

import UIKit

public enum Border: CGFloat {
    case thin = 0.5
    case light = 1
    case thick = 2
    case heavy = 4
}

public extension UIView {
    var border: Border? {
        get { Border(rawValue: layer.borderWidth) }
        set { layer.borderWidth = newValue?.rawValue ?? .zero }
    }
    
    var borderColor: UIColor? {
        get {
            guard let cgColor = layer.borderColor else {
                return nil
            }
            return UIColor(cgColor: cgColor)
        }
        set {
            layer.borderColor = newValue?.cgColor
        }
    }
}
