//
//  DependencyType.swift
//
//
//  Created by Zain Ul Abe Din on 08/10/2024.
//

import Foundation

public protocol DependencyType {
    var apiClient: APIClientType { get }
    var appInfoProvider: AppInfoProviderType { get }
}
