//
//  SocketAckRequest.swift
//  Networking
//
//  Created by Zain Ul Abedin on 22/01/2025.
//

import Foundation

struct SocketAckRequest: Encodable {
    let timeout: Int
    let ack: Int
}
