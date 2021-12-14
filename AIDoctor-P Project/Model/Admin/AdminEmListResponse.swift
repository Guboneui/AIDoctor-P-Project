//
//  AdminEmListResponse.swift
//  AIDoctor-P Project
//
//  Created by 구본의 on 2021/12/14.
//

import Foundation

struct AmdinEmListResponse: Decodable {
    var isSuccess: Bool
    var code: Int
    var message: String
    var results: AdminResults?
}

struct AdminResults: Decodable {
    var results: [AmdinEmList]
}

struct AmdinEmList: Decodable {
    var USER_ID: Int
    var USER_USERID: String
}
