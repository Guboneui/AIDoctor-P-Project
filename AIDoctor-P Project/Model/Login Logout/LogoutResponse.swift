//
//  LogoutResponse.swift
//  AIDoctor-P Project
//
//  Created by 구본의 on 2021/12/06.
//

import Foundation

struct LogoutResponse: Decodable {
    var isSuccess: Bool
    var code: Int
    var message: String
}
