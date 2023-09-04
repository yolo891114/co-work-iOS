//
//  UserCollect.swift
//  STYLiSH
//
//  Created by jeff on 2023/9/4.
//  Copyright © 2023 AppWorks School. All rights reserved.
//

import Foundation

// MARK: - UserCollect
struct UserCollect: Codable {
    let userID: String
    let eventType: String = "collect"
    let eventDetail: EventDetailForCollect
    let timestamp, version: String

    enum CodingKeys: String, CodingKey {
        case userID
        case eventType = "event_type"
        case eventDetail = "event_detail"
        case timestamp, version
    }
}

// MARK: - EventDetail
struct EventDetailForCollect: Codable {
    let action: String
    let collectItem: Int

    enum CodingKeys: String, CodingKey {
        case action
        case collectItem = "collect_item"
    }
}
