//
//  NetworkRouterType.swift
//
//
//  Created by Zain Ul Abe Din on 02/10/2024.
//

import Foundation

public enum AuthorizationType {
    case basic
    case bearer
    case cookie
    case none
}

public enum APPHTTPMethod: String {
    case options = "OPTIONS"
    case get     = "GET"
    case head    = "HEAD"
    case post    = "POST"
    case put     = "PUT"
    case patch   = "PATCH"
    case delete  = "DELETE"
    case trace   = "TRACE"
    case connect = "CONNECT"
}

public enum ContentType: String {
    case json = "application/json; charset=UTF-8"
    case xwwwFormURLEncoded = "application/x-www-form-urlencoded"
    case multiPartFormData = "multipart/form-data"
    case ndJson = "application/x-ndjson"
    case image = "image/jpeg"
    case audio = "audio/aac"
}

public protocol NetworkRouterType {
    var httpMethod: APPHTTPMethod { get }
    var url: String { get }
    var httpBody: Data? { get }
    var dateDecodingStrategy: JSONDecoder.DateDecodingStrategy { get }
    var authorization: AuthorizationType { get }
    var contentType: ContentType { get }
    
    func asUrlRequest() -> URLRequest
}

public extension NetworkRouterType {
    var dateDecodingStrategy: JSONDecoder.DateDecodingStrategy {
        .secondsSince1970
    }
    
    var authorization: AuthorizationType {
        return .none
    }
    
    var contentType: ContentType {
        return .json
    }
}
