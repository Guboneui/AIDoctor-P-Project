//
//  SetTokenRequest.swift
//  AIDoctor-P Project
//
//  Created by 구본의 on 2021/12/14.
//

import Foundation

struct SetTokenRequest: Encodable {
    var userId: Int
    var token: String
}
