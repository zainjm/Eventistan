//
//  UIImage+Ext.swift
//  Extensions
//
//  Created by Muhammad Ruman on 10/12/2024.
//

import UIKit

public extension UIImage {
    /// Returns an image with `.alwaysOriginal` rendering mode from the given name.
    /// - Parameter named: The name of the image.
    /// - Returns: A `UIImage` object with `.alwaysOriginal` rendering mode, or `nil` if the image couldn't be loaded.
    static func pdf(named: String) -> UIImage? {
        return UIImage(named: named)?.withRenderingMode(.alwaysOriginal)
    }
}
