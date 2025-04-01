//
//  TrustValidator.swift
//
//
//  Created by Zain Ul Abe Din on 02/10/2024.
//

import Foundation
import Alamofire

protocol TrustValidator {
    func performValidation(forHost host: String) throws
    func performDefaultValidation(forHost host: String) throws
}

extension AlamofireExtension<SecTrust>: TrustValidator { }

typealias AlamofireTrustValidator = AlamofireExtension<SecTrust>
