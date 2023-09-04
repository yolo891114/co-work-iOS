//
//  UserHover.swift
//  STYLiSH
//
//  Created by jeff on 2023/9/4.
//  Copyright © 2023 AppWorks School. All rights reserved.
//

import Foundation

// MARK: - UserHover
struct UserHover: Codable {
    let userID, eventType: String
    let eventDetail: EventDetailForHover
    let timestamp, version: String

    enum CodingKeys: String, CodingKey {
        case userID
        case eventType = "event_type"
        case eventDetail = "event_detail"
        case timestamp, version
    }
}

// MARK: - EventDetail
struct EventDetailForHover: Codable {
    let checkout, regret: String
}
