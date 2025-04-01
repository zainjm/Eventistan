//
//  UIFont+TextStyle.swift
//  
//
//  Created by Zain Ul Abe Din on 03/10/2024.
//

import UIKit

public extension UIFont {
    // MARK: - Heading
    /// Heading 1: 48pt / Bold
    static let heading1 = font(48, .bold)
    /// Heading 2: 40pt / Bold
    static let heading2 = font(40, .bold)
    /// Heading 3: 32pt / Bold
    static let heading3 = font(32, .bold)
    /// Heading 4: 24pt / Bold
    static let heading4 = font(24, .bold)
    /// Heading 5: 20pt / Bold
    static let heading5 = font(20, .bold)
    /// Heading 6: 18pt / Bold
    static let heading6 = font(18, .bold)
    
    // MARK: - Body
    /// Body Jumbo: 20pt / Regular
    static let bodyJumbo  = font(20, .regular)
    /// Body XLarge: 18pt / Regular
    static let bodyXLarge = font(18, .regular)
    /// Body Large: 16pt / Regular
    static let bodyLarge  = font(16, .regular)
    /// Body Medium: 14pt / Regular
    static let bodyMedium = font(14, .regular)
    /// Body Small: 12pt / Regular
    static let bodySmall  = font(12, .regular)
    /// Body XSmall: 10pt / Regular
    static let bodyXSmall = font(10, .regular)
    
    // MARK: - Dynamic text style function
    /// If you still want a flexible method for custom sizes/weights:
    static func textStyle(
        with _font: AppFont = AppTheme.font,
        _ textSize: TextSize,
        _ textWeight: TextWeight
    ) -> UIFont {
        font(with: _font, textSize, textWeight)
    }
}

// MARK: - Internal Utils
private extension UIFont {
    /// Overload taking `TextSize` + `TextWeight`
    static func font(
        with _font: AppFont = AppTheme.font,
        _ textSize: TextSize,
        _ textWeight: TextWeight
    ) -> UIFont {
        switch _font {
        case .system:
            return UIFont.systemFont(ofSize: textSize.size, weight: textWeight.fontWeight)
        case .custom(let customFont):
            return UIFont(
                name: customFont.name(for: textWeight),
                size: textSize.size
            ) ?? font(with: .system, textSize, textWeight)
        }
    }
    
    /// Overload taking raw CGFloat size + `TextWeight`
    static func font(
        with _font: AppFont = AppTheme.font,
        _ textSize: CGFloat,
        _ textWeight: TextWeight
    ) -> UIFont {
        switch _font {
        case .system:
            return UIFont.systemFont(ofSize: textSize, weight: textWeight.fontWeight)
        case .custom(let customFont):
            return UIFont(
                name: customFont.name(for: textWeight),
                size: textSize
            ) ?? font(with: .system, textSize, textWeight)
        }
    }
}
