//
//  UIFont+TextStyle.swift
//  
//
//  Created by Zain Ul Abe Din on 03/10/2024.
//

import UIKit

public extension UIFont {
    // MARK: - Font tokens
    static let headline1 = font(44, .medium)
    static let headline2 = font(35, .medium)
    static let headline3 = font(26, .medium)
    static let headline4 = font(26, .regular)
    static let headline5 = font(22, .medium)
    static let headline6 = font(22, .regular)
    
    static let paragraph1 = font(20, .medium)
    static let paragraph2 = font(18, .regular)
    static let paragraph3 = font(18, .medium)
    static let paragraph4 = font(15, .regular)
    static let paragraph5 = font(15, .medium)
    static let paragraph6 = font(13, .regular)
    static let paragraph7 = font(13, .medium)
    static let paragraph8 = font(13, .medium)
    static let paragraph9 = font(12, .regular)
    static let paragraph10 = font(12, .medium)
    static let paragraph11 = font(9, .medium)
    static let paragraph12 = font(14, .regular)
    static let paragraph13 = font(14, .medium)
    static let paragraph14 = font(11, .regular)
    static let paragraph15 = font(11, .medium)
    static func textStyle(
        with _font: AppFont = AppTheme.font,
        _ textSize: TextSize,
        _ textWeight: TextWeight
    ) -> UIFont {
        font(with: _font, textSize, textWeight)
    }
}

// MARK: - Utils
private extension UIFont {
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
