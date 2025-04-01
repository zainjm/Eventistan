//
//  SecuredKeyProviderType.swift
//
//
//  Created by Zain Ul Abe Din on 02/10/2024.
//

import Foundation

public typealias SecurityKeyInfo = (publicKeyHashes: [String], hostName: String)

public protocol SecuredKeyProviderType {
    var publicKeyInfo: SecurityKeyInfo? { get }
}
