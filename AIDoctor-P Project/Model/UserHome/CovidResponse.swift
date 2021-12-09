//
//  CovidResponse.swift
//  AIDoctor-P Project
//
//  Created by 구본의 on 2021/12/09.
//

import Foundation

struct CovidResponse: Decodable {
    var isSuccess: Bool
    var code: Int
    var message: String
    var results: Int?
}

