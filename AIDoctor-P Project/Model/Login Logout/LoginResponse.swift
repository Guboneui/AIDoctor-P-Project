//
//  LoginResponse.swift
//  AIDoctor-P Project
//
//  Created by 구본의 on 2021/12/06.
//

import Foundation

struct LoginResponse: Decodable {
    var isSuccess: Bool
    var code: Int
    var message: String
    var user: UserInfo?
}

struct UserInfo: Decodable {
    var USER_ID: Int
    var USER_USERID: String
    var USER_ISADMIN: Int
}
