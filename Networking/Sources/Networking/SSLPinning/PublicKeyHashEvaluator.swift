//
//  PublicKeyHashEvaluator.swift
//
//
//  Created by Zain Ul Abe Din on 02/10/2024.
//

import Foundation
import Alamofire
import CommonCrypto

// MARK: - Public key hash evaluator
final class PublicKeyHashEvaluator {
    // MARK: - Properties
    private let publicKeyHashes: [String]
    private let trustValidatorProvider: TrustValidatorProvider
    
    // MARK: - Initializer
    init(
        _ publicKeyHashes: [String],
        trustValidatorProvider: TrustValidatorProvider = AlamofireTrustValidatorProvider()
    ) {
        self.publicKeyHashes = publicKeyHashes
        self.trustValidatorProvider = trustValidatorProvider
    }
}

// MARK: - Validations
private extension PublicKeyHashEvaluator {
    func validateKeyHashes(_ trust: SecTrust) -> Bool {
        guard let certificates = SecTrustCopyCertificateChain(trust) as? [SecCertificate] else {
            return false
        }
        
        for certificate in certificates {
            guard let publicKey = SecCertificateCopyKey(certificate),
                  let publicKeyData = SecKeyCopyExternalRepresentation(publicKey, nil) else {
                return false
            }
            
            let keyHash = hash(data: (publicKeyData as NSData) as Data)
            
            if publicKeyHashes.contains(keyHash) {
                return true
            }
        }
        
        return false
    }
    
    func hash(data: Data) -> String {
        let rsa2048Asn1Header: [UInt8] = [
            0x30, 0x82, 0x01, 0x22, 0x30, 0x0d, 0x06, 0x09, 0x2a, 0x86, 0x48, 0x86,
            0xf7, 0x0d, 0x01, 0x01, 0x01, 0x05, 0x00, 0x03, 0x82, 0x01, 0x0f, 0x00
        ]
        
        var keyWithHeader = Data(rsa2048Asn1Header)
        keyWithHeader.append(data)
        
        var hash = [UInt8](repeating: 0, count: Int(CC_SHA256_DIGEST_LENGTH))
        _ = keyWithHeader.withUnsafeBytes {
            CC_SHA256($0.baseAddress!, CC_LONG(keyWithHeader.count), &hash)
        }
        return Data(hash).base64EncodedString()
    }
}

// MARK: - Server trust evaluating
extension PublicKeyHashEvaluator: ServerTrustEvaluating {
    func evaluate(_ trust: SecTrust, forHost host: String) throws {
        let trustValidator = trustValidatorProvider.validator(forTrust: trust)
        try trustValidator.performValidation(forHost: host)
        try trustValidator.performDefaultValidation(forHost: host)
        
        guard validateKeyHashes(trust) else {
            throw AFError.serverTrustEvaluationFailed(
                reason: .publicKeyPinningFailed(
                    host: host,
                    trust: trust,
                    pinnedKeys: [],
                    serverKeys: trust.af.publicKeys
                )
            )
        }
    }
}
