//
//  Dependency.swift
//  MotorsScaffold
//
//  Created by Zain Ul Abe Din on 09/10/2024.
//

import Foundation
import Types
import Networking

final public class Dependency: DependencyType {

    
    // MARK: - Properties
    lazy public var tracker: any TrackerType = Tracker()
    lazy public var appInfoProvider: any AppInfoProviderType = AppInfoProvider()
    lazy public var apiClient: any APIClientType = {
        var config = URLSessionConfiguration.default
        config.requestCachePolicy = .useProtocolCachePolicy
        return APIClient(
            tokenProvider: nil,
            appInfoProvider: AppInfoProvider(),
            securedKeyProvider: SecuredKeyProvider(),
            tracker: tracker
        )
    }()

    
    // MARK: - Initialization
    public init() {}
}
