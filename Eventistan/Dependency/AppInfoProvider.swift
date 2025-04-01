//
//  AppInfoProvider.swift
//  MotorsScaffold
//
//  Created by Zain Ul Abe Din on 09/10/2024.
//

import Types
import UIKit
import Extensions

final class AppInfoProvider: AppInfoProviderType {
    var language: String = Locale.current.languageCode ?? .empty
    var version: String = Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString") as? String ?? .empty
    var buildNumber: String = Bundle.main.object(forInfoDictionaryKey: "CFBundleVersion") as? String ?? .empty
    var name: String = Bundle.main.object(forInfoDictionaryKey: "CFBundleName") as? String ?? .empty
    var bundleIdentifier: String = Bundle.main.bundleIdentifier ?? .empty
    var osVersion: String = UIDevice.current.systemVersion
    var deviceMake: String = "Apple"
    var deviceModel: String = UIDevice.current.model
    var deviceOs: String = "iOS"
    var platform: String = "Mobile"
}
