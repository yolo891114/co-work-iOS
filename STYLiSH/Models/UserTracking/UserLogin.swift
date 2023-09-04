//
//  UserLogin.swift
//  STYLiSH
//
//  Created by jeff on 2023/9/4.
//  Copyright © 2023 AppWorks School. All rights reserved.
//

import Foundation

// MARK: - UserLogin
struct UserLogin: Codable {
    let userID, eventType, timestamp: String
    let version: String
    let eventDetail: String = "None"

    enum CodingKeys: String, CodingKey {
        case userID
        case eventType = "event_type"
        case eventDetail = "event_detail"
        case timestamp, version
    }
    
}
