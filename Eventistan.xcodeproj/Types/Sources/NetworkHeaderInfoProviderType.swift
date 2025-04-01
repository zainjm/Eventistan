//
//  NetworkHeaderInfoProviderType.swift
//
//
//  Created by Zain Ul Abe Din on 03/10/2024.
//

import Foundation

public protocol AppInfoProviderType {
    var version: String { get }
    var buildNumber: String { get }
    var name: String { get }
    var bundleIdentifier: String { get }
    var osVersion: String { get }
    var deviceMake: String { get }
    var deviceModel: String { get }
    var deviceOs: String { get }
    var platform: String { get }
    var language: String { get }
}
