//
//  SendChatBotResponse.swift
//  AIDoctor-P Project
//
//  Created by 구본의 on 2021/12/11.
//

import Foundation

struct SendChatBotResponse: Decodable {
    var isSuccess: Bool
    var code: Int
    var message: String
    var results: [SendChatResults]?
}

struct SendChatResults: Decodable {
    var type: String
    var message: SendChatMessage
}

struct SendChatMessage: Decodable {
    var title: String
    var listItem: [SendListItem]?
}


struct SendListItem: Decodable {
    var label: String
    var value: String
    var required: String
}
