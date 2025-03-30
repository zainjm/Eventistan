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
        case geomanist = "Geomanist"
        
        func supportedWeight(for textWieght: TextWeight) -> TextWeight {
            switch self {
            case .geomanist:
                if [.ultraLight, .thin, .light, .regular].contains(textWieght) {
                    return .regular
                } else {
                    return .medium
                }
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
