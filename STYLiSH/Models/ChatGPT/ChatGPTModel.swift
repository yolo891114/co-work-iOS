//
//  ChatGPTModel.swift
//  STYLiSH
//
//  Created by jeff on 2023/9/5.
//  Copyright © 2023 AppWorks School. All rights reserved.
//

import Foundation

struct ChatRequest: Codable {
    let tag: String
}

struct ChatResponse: Codable {
    let chatResponse: String
    let productId: Int
    
    enum CodingKeys: String, CodingKey {
        case chatResponse = "chat_response"
        case productId = "product_id"
    }
}
