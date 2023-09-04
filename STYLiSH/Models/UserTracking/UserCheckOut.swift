//
//  UserCheckOut.swift
//  STYLiSH
//
//  Created by jeff on 2023/9/4.
//  Copyright © 2023 AppWorks School. All rights reserved.
//

import Foundation

// MARK: - UserCheckOut
struct UserCheckOut: Codable {
    let userID, eventType: String
    let eventDetail: EventDetailForCheckOut
    let timestamp, version: String

    enum CodingKeys: String, CodingKey {
        case userID
        case eventType = "event_type"
        case eventDetail = "event_detail"
        case timestamp, version
    }
}

// MARK: - EventDetail
struct EventDetailForCheckOut: Codable {
    let checkoutItem: [String]

    enum CodingKeys: String, CodingKey {
        case checkoutItem = "checkout_item"
    }
}
