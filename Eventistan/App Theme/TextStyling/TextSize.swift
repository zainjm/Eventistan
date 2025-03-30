//
//  TextSize.swift
//  
//
//  Created by Zain Ul Abe Din on 03/10/2024.
//

import Foundation

public enum TextSize {
    case heading1
    case heading2
    case heading3
    case heading4
    case heading5
    case heading6
    case heading7
    case subtitle1
    case subtitle2
    case body
    case base
    case caption1
    case caption2
    case overline
    
    var size: CGFloat {
        switch self {
        case .heading1: return 72
        case .heading2: return 60
        case .heading3: return 48
        case .heading4: return 40
        case .heading5: return 36
        case .heading6: return 32
        case .heading7: return 28
        case .subtitle1: return 24
        case .subtitle2: return 20
        case .body: return 18
        case .base: return 16
        case .caption1: return 14
        case .caption2: return 12
        case .overline: return 10
        }
    }
}
