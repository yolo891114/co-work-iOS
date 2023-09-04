//
//  Review.swift
//  STYLiSH
//
//  Created by TingFeng Shen on 2023/9/3.
//  Copyright © 2023 AppWorks School. All rights reserved.
//


import Foundation

// MARK: - Review
struct Review: Codable {
    let userID: String
    let productID: Int
    let review, timestamp, version: String

    enum CodingKeys: String, CodingKey {
        case userID
        case productID = "product_id"
        case review, timestamp, version
    }
}
