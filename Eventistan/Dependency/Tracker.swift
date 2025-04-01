//
//  Tracker.swift
//  MotorsScaffold
//
//  Created by Zain Ul Abe Din on 09/10/2024.
//

import Foundation
import Types

enum TrackerError: Error {
    case trackerNotAvailable
}

final class Tracker: TrackerType {
    func track<T>(eventType: Types.EventType) async -> Result<T, any Error> where T : Decodable {
        return .failure(TrackerError.trackerNotAvailable)
    }
    
    func track(eventType: EventType) {}
    func resetAttributes() {}
    func setUserAttributes() {}
    func setCustomAttributes(_ attributes: [String : Any?]) {}
}
