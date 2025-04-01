//
//  HeaderField.swift
//  
//
//  Created by Zain Ul Abe Din on 03/10/2024.
//

import Foundation

public enum HeaderField: String {
    case userAgent        = "User-Agent"
    case phoneMake        = "X-Phone-Make"
    case phoneModel       = "X-Phone-Model"
    case appId            = "X-App-Id"
    case deviceOS         = "X-Device-OS"
    case platform         = "X-Platform"
    case appVersion       = "X-App-Version"
    case authorization    = "Authorization"
    case signature        = "X-Signature"
    case acceptLanguage   = "Accept-Language"
    case acceptType       = "Accept"
    case contentType      = "Content-Type"
    case contentLanguage  = "Content-Language"
    case cookie           = "Cookie"
}
