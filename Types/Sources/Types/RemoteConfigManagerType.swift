//
//  RemoteConfigManagerType.swift
//  Types
//
//  Created by Mashood Murtaza on 27/02/2025.
//

import Foundation

public enum RemoteConfigKeys: String {
    case fieldRoles = "field_roles"
}

public protocol RemoteConfigManagerType: AnyObject {
    func start()
    func getValue<T>(forKey key: RemoteConfigKeys) -> T?
}
