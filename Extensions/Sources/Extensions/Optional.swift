//
//  File 2.swift
//  Extensions
//
//  Created by Zain Najam Khan on 02/04/2025.
//

import Foundation

public extension Optional {
    var isNil: Bool { self == nil }
    var exists: Bool { self != nil }
}
