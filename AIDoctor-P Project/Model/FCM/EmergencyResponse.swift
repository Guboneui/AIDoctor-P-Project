//
//  EmergencyResponse.swift
//  AIDoctor-P Project
//
//  Created by 구본의 on 2021/12/14.
//

import Foundation

struct EmergencyResponse: Decodable {
    var isSuccess: Bool
    var code: Int
    var message: String
    
}
