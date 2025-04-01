//
//  Encodable+SocketData.swift
//  Networking
//
//  Created by Zain Ul Abe Din on 22/01/2025.
//

import Foundation
import SocketIO

extension Encodable {
    func asSocketData() -> SocketData? {
        do {
            let encoder = JSONEncoder()
            encoder.dateEncodingStrategy = .millisecondsSince1970
            let jsonData = try encoder.encode(self)
            let jsonObject = try JSONSerialization.jsonObject(with: jsonData, options: .fragmentsAllowed)
            return jsonObject as? SocketData
        } catch {
            debugPrint("Error converting \(self) to JSON: \(error)")
            return nil
        }
    }
}
