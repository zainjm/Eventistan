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
        guard textWeight != .regular else { return rawValue }
        return rawValue + "-" + supportedWeight(for: textWeight).rawValue
    }
}
