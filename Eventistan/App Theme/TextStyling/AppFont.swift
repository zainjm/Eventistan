//
//  AppFont.swift
//
//
//  Created by Zain Ul Abe Din on 03/10/2024.
//

import UIKit

public enum AppFont {
    case system
    case custom(Custom)
    
    public enum Custom: String {
        case DMSans = "DMSans"
        
        func supportedWeight(for textWeight: TextWeight) -> TextWeight {
                switch textWeight {
                case .ultraLight, .thin, .light:
                    return .light
                case .regular:
                    return .regular
                case .medium:
                    return .medium
                case .semibold:
                    return .semibold
                case .bold, .heavy, .black:
                    return .bold
                }
            }
    }
}

extension AppFont.Custom {
    func name(for textWeight: TextWeight) -> String {
        let finalWeight = supportedWeight(for: textWeight)
        switch finalWeight {
        case .light:
            return "DMSans-9ptRegular_Light"
        case .regular:
            return "DMSans-9ptRegular"
        case .medium:
            return "DMSans-9ptRegular_Medium"
        case .semibold:
            return "DMSans-9ptRegular_SemiBold"
        case .bold:
            return "DMSans-9ptRegular_Bold"
        default:
            return "DMSans-9ptRegular"
        }
    }
}
