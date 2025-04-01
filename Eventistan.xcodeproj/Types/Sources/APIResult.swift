//
//  APIResult.swift
//  Types
//
//  Created by Zain Ul Abe Din on 02/10/2024.
//

import Foundation

public struct APISuccess {
    public let data: Data?
    public let responseCode: Int
    
    public init(data: Data?, responseCode: Int) {
        self.data = data
        self.responseCode = responseCode
    }
}

public struct APIFailure: Error {
    public let data: Data?
    public let responseCode: Int
    
    public init(data: Data?, responseCode: Int) {
        self.data = data
        self.responseCode = responseCode
    }
}
