//
//  UserInfoProvider.swift
//  PK
//
//  Created by Zain Ul Abe Din on 06/11/2024.
//

import Types
import Foundation
import Extensions

final class UserInfoProvider {
    // MARK: - Properties
    private let store: StoreType
    private let tokenProvider: TokenProviderType
    
    private struct Constants {
        static let language = "language"
        static let isAgent = "is_agent"
        static let isVerified = "is_verified"
    }
    
    // MARK: - Initialization
    init(store: StoreType, tokenProvider: TokenProviderType) {
        self.store = store
        self.tokenProvider = tokenProvider
    }
}

extension UserInfoProvider: UserInfoProviderType {
    var isFreshInstall: Bool {
        (try? store.data(for: CommonConstants.isFreshInstallKey)) ?? true
    }
    
    func setFreshInstall(_ isFreshInstall: Bool) {
        try? store.save(data: isFreshInstall, for: CommonConstants.isFreshInstallKey)
    }
    
    var isUserLoggedIn: Bool {
        tokenProvider.tokenInfo.exists
    }
    
    var userName: String? {
        if let idToken = tokenProvider.tokenInfo?.idToken {
            let idTokenDict = JWTDecoder.decode(jwtToken: idToken)
            return idTokenDict["name"] as? String
        }
        return nil
    }
    
    var userExternalId: String? {
        if let idToken = tokenProvider.tokenInfo?.idToken {
            let idTokenDict = JWTDecoder.decode(jwtToken: idToken)
            return idTokenDict["external_id"] as? String
        }
        return nil
    }
    
    var phoneNumber: String? {
        if let idToken = tokenProvider.tokenInfo?.idToken {
            let idTokenDict = JWTDecoder.decode(jwtToken: idToken)
            return idTokenDict["phone_number"] as? String
        }
        return nil
    }
    
    var email: String? {
        if let idToken = tokenProvider.tokenInfo?.idToken {
            let idTokenDict = JWTDecoder.decode(jwtToken: idToken)
            return idTokenDict["email"] as? String
        }
        return nil
    }
    
    var birthday: String? {
        if let idToken = tokenProvider.tokenInfo?.idToken {
            let idTokenDict = JWTDecoder.decode(jwtToken: idToken)
            return idTokenDict["birthday"] as? String
        }
        return nil
    }
    
    var description: String? {
        if let idToken = tokenProvider.tokenInfo?.idToken {
            let idTokenDict = JWTDecoder.decode(jwtToken: idToken)
            return idTokenDict["description"] as? String
        }
        return nil
    }
    
    var imageId: String? {
        if let idToken = tokenProvider.tokenInfo?.idToken {
            let idTokenDict = JWTDecoder.decode(jwtToken: idToken)
            return idTokenDict["image_id"] as? String
        }
        return nil
    }
    
    var dateOfBirth: Date? {
        guard let birthday = self.birthday, let seconds = Double(birthday) else { return nil }
        return Date(timeIntervalSince1970: seconds)
    }
    
    public var createdAt: String? {
        return try? store.data(for: CommonConstants.createdAtKey)
    }
}

public struct JWTDecoder {
    static func decode(jwtToken jwt: String) -> [String: Any] {
        let segments = jwt.components(separatedBy: ".")
        guard !segments.isEmpty else { return [:] }
        return decodeJWTPart(segments[1]) ?? [:]
      }
    
    static func base64UrlDecode(_ value: String) -> Data? {
      var base64 = value
        .replacingOccurrences(of: "-", with: "+")
        .replacingOccurrences(of: "_", with: "/")

      let length = Double(base64.lengthOfBytes(using: String.Encoding.utf8))
      let requiredLength = 4 * ceil(length / 4.0)
      let paddingLength = requiredLength - length
      if paddingLength > 0 {
        let padding = "".padding(toLength: Int(paddingLength), withPad: "=", startingAt: 0)
        base64 = base64 + padding
      }
      return Data(base64Encoded: base64, options: .ignoreUnknownCharacters)
    }

    static func decodeJWTPart(_ value: String) -> [String: Any]? {
      guard let bodyData = base64UrlDecode(value),
        let json = try? JSONSerialization.jsonObject(with: bodyData, options: []), let payload = json as? [String: Any] else {
          return nil
      }

      return payload
    }
}
