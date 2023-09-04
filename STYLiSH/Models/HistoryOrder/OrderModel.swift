//
//  OrderModel.swift
//  STYLiSH
//
//  Created by jeff on 2023/9/4.
//  Copyright © 2023 AppWorks School. All rights reserved.
//

import Foundation

// MARK: - Order
struct OrderModel: Codable {
    let userID, checkoutDate, orderNumber: String
    let totalPrice: Int
    let checkoutItem: [String]?
    let comment: String

    enum CodingKeys: String, CodingKey {
        case userID = "user_Id"
        case checkoutDate = "checkout_date"
        case orderNumber = "order_number"
        case totalPrice = "total_price"
        case checkoutItem = "checkout_item"
        case comment
    }
}
