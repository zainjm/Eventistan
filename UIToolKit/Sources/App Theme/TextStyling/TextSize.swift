//
//  TextSize.swift
//  
//
//  Created by Zain Ul Abe Din on 03/10/2024.
//

import Foundation

public enum TextSize {
    // Example headings from Figma
    case heading1
    case heading2
    case heading3
    case heading4
    case heading5
    case heading6
    
    // Example body sizes
    case bodyXLarge
    case bodyLarge
    case bodyMedium
    case bodySmall
    case bodyXSmall
    
    // Example captions/overlines
    case caption
    case overline
    
    /// The size in points (pt)
    var size: CGFloat {
        switch self {
        case .heading1:    return 48
        case .heading2:    return 40
        case .heading3:    return 32
        case .heading4:    return 24
        case .heading5:    return 20
        case .heading6:    return 18
            
        case .bodyXLarge:  return 20
        case .bodyLarge:   return 18
        case .bodyMedium:  return 16
        case .bodySmall:   return 14
        case .bodyXSmall:  return 12
            
        case .caption:     return 12
        case .overline:    return 10
        }
    }
    
    /// The weight (e.g. Regular, Bold, etc.)
    var textWeight: TextWeight {
        switch self {
        case .heading1, .heading2, .heading3:
            return .bold
        case .heading4, .heading5:
            return .semibold
        case .heading6:
            return .medium
        case .bodyXLarge, .bodyLarge, .bodyMedium, .bodySmall, .bodyXSmall:
            return .regular
        case .caption, .overline:
            return .regular
        }
    }
}
