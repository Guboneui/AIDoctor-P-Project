//
//  StartChatBotResponse.swift
//  AIDoctor-P Project
//
//  Created by 구본의 on 2021/12/11.
//

import Foundation

struct StartChatBotResponse: Decodable {
    var isSuccess: Bool
    var code: Int
    var message: String
    var results: StartChatResult?
}

struct StartChatResult: Decodable {
    var thumbnail: String
    var title: String
    var listItem: [StartListItem]?
}

struct StartListItem: Decodable {
    var label: String
    var value: String
    var required: Bool
}
