//
//  TrustValidatorProvider.swift
//
//
//  Created by Zain Ul Abe Din on 02/10/2024.
//

import Foundation

protocol TrustValidatorProvider {
    func validator(forTrust trust: SecTrust) -> TrustValidator
}

final class AlamofireTrustValidatorProvider: TrustValidatorProvider {
    func validator(forTrust trust: SecTrust) -> TrustValidator {
        return AlamofireTrustValidator(trust)
    }
}
