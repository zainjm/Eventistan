//
//  TrackerType.swift
//
//
//  Created by Zain Ul Abe Din on 03/10/2024.
//

import Foundation

// MARK: - Metric Entity
public enum MetricEntity: String {
    /// Impressions
    case ad = "ad"
    /// Leads
    case phone = "phone"
    case sms = "sms"
    case whatsapp = "whatsapp"
    case email = "email"
    case chat = "chat"
}

// MARK: - Metric Source
public enum MetricSource: String {
    case search = "search" // LPV
    case details = "details" //DPV
}

// MARK: - Metric Action
public enum MetricAction: String {
    case view = "view"
    case lead = "lead"
}

public enum EventType {
    case event(name: String, params: [String: Any])
}

public protocol TrackerType {
    func resetAttributes()
    func setUserAttributes()
    func setCustomAttributes(_ attributes: [String : Any?])
    func track(eventType: EventType)
    func track<T>(eventType: EventType) async ->  Result<T, Error> where T: Decodable
}

public extension TrackerType {
    func track(eventType: EventType) {}
}
