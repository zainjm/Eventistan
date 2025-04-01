//
//  ResourceType.swift
//  
//
//  Created by Muhammad Ruman on 21/10/2024.
//

import Foundation

public protocol ResourceType {
    static func loadResource<T: Decodable>(
        of type: String,
        with name: String,
        bundle: Bundle
    ) -> T?
}
