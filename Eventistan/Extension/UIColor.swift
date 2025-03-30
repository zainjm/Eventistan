//
//  UIColor+AppColors.swift
//
//
//  Created by Zain Ul Abe Din on 04/10/2024.
//

import UIKit

public extension UIColor {
    
    static let dark = "dark".color
    static let grey = "grey".color
    static let light = "light".color
    static let teal = "teal".color
    static let whatsapp = "whatsapp".color
    
    // MARK: - Primary Colors
    static let primaryYellow = "primaryYellow".color
    static let primaryWhite = "primaryWhite".color
    static let primaryTeal = "primaryTeal".color
    static let primaryRed = "primaryRed".color
    static let primaryBlack = "primaryBlack".color
    static let primaryGrey = "primaryGrey".color
    static let primaryBlue = "primaryBlue".color
    static let primaryShadow = "primaryShadow".color
    static let background = "background".color
    static let overlay = "overlay".color
    
    // MARK: - Secondary Colors
    /// To be used if white shadow needed for dark mode as well
    static let secondaryShadow = "secondaryShadow".color

    
    // MARK: - Yellow Shades
    static let yellow100 = "yellow100".color
    static let yellow200 = "yellow200".color
    static let yellow300 = "yellow300".color
    static let yellow400 = "yellow400".color
    static let yellow500 = "yellow500".color
    static let yellow600 = "yellow600".color
    static let yellow700 = "yellow700".color
    
    // MARK: - Grey Shades
    static let grey100 = "grey100".color
    static let grey200 = "grey200".color
    static let grey300 = "grey300".color
    static let grey400 = "grey400".color
    static let grey500 = "grey500".color
    static let grey600 = "grey600".color
    static let grey700 = "grey700".color
    
    // MARK: - Red Shades
    static let red100 = "red100".color
    static let red200 = "red200".color
    static let red300 = "red300".color
    static let red400 = "red400".color
    static let red500 = "red500".color
    static let red600 = "red600".color
    static let red700 = "red700".color
    
    // MARK: - Teal Shades
    static let teal100 = "teal100".color
    static let teal200 = "teal200".color
    static let teal300 = "teal300".color
    static let teal400 = "teal400".color
    static let teal500 = "teal500".color
    static let teal600 = "teal600".color
    static let teal700 = "teal700".color
    
    // MARK: - Blue Shades
    static let blue100 = "blue100".color
    static let blue200 = "blue200".color
    static let blue300 = "blue300".color
    static let blue400 = "blue400".color
    static let blue500 = "blue500".color
    static let blue600 = "blue600".color
    static let blue700 = "blue700".color
    static let blueBorder = "blue-border".color
    
    var invertedAppearance: UIColor {
        let invertedUserInterfaceStyle: UIUserInterfaceStyle = UITraitCollection.current.userInterfaceStyle == .dark ? .light : .dark
        return resolvedColor(with: UITraitCollection(userInterfaceStyle: invertedUserInterfaceStyle))
    }
    
    static let viewBackground = "viewBackground".color
}

fileprivate extension String {
    var color: UIColor {
        UIColor(
            named: AppTheme.colorTheme.rawValue + "-" + self,
            in: .main,
            compatibleWith: nil
        ) ?? .clear
    }
}
