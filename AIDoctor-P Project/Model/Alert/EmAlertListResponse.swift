//
//  EmAlertListResponse.swift
//  AIDoctor-P Project
//
//  Created by 구본의 on 2021/12/14.
//

import Foundation

struct EmAlertListResponse: Decodable {
    var isSuccess: Bool
    var code: Int
    var message: String
    var results: EmAlertResults?
}

struct EmAlertResults: Decodable {
    var results: [EmAlertList]
}

struct EmAlertList: Decodable {
    var FCM_ID: Int
    var FCM_USER_ID: Int
    var FCM_CONTENT: String
    var FCM_DATE: String
}
