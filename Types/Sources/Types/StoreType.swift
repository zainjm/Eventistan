//
//  StoreType.swift
//
//
//  Created by Zain Ul Abe Din on 09/10/2024.
//

import Foundation

public protocol StoreType {
    func save<T>(data: T, for key: String) throws where T : Encodable
    func data<T>(for key: String) throws -> T? where T : Decodable
    func lastUpdatedAt(for key: String) throws -> Date?
    func deleteData(for key: String) throws
    func startObservingUpdates(for key: String, observationHandler: @escaping () -> Void)
    func clear() throws
}

// MARK: - Optional implementation
public extension StoreType {
    func startObservingUpdates<T>(for key: String, observationHandler: @escaping (T) -> Void) throws where T: Decodable { }
}
