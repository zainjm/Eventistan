//
//  File.swift
//  Types
//
//  Created by Zain Najam Khan on 02/04/2025.
//

import Foundation

public struct CommonConstants {
    public static let recentLocationsKey = "RECENT_LOCATIONS"
    public static let favouriteAdsKey = "USERS_FAVOURITES"
    public static let savedSearchesKey = "USERS_SAVED_SEARCHES"
    public static let isVerifiedKey = "IS_VERIFIED"
    public static let createdAtKey = "CREATED_AT"
    public static let agencyDetailKey = "AGENCY_DETAIL"
    public static let previousUser = "previousUser"
    public static let isFreshInstallKey = "IS_FRESH_INSTALL"
    public static let refreshFailure = "refreshFailure"
    public static let chatRoomKey = "CHAT_ROOMS"
    public static let errorCodes = 399...500
    public static let unAuthCodes = 400...401
    public static let allCategoriesKey = "ALL_CATEGORIES"
    public static let allRecentSearchesKey = "RECENT_SEARCHES"
    public static let motorsRecentSearchesKey = "RECENT_SEARCHES_MOTORS"
    public static let moengageOfferNotificationsKey = "offersNotificationSettings"
    public static let moengageRecommendationNotificationsKey = "recommendationsNotificationSettings"
    public static let allowedHosts = ["www.olx.com.pk", "blog.olx.com.pk", "help.olx.com.pk"]
    public static let adIdChunkSize = 8
}

public enum KeyCloakError: Int {
    case invalid = 400
    case unauthorized = 401
    case expired = 410
    case tooManyAttempts = 429
    case other
}

public enum OTPFlowType {
    case myProfile
    case postAd
    case buyPackages
}
