//
//  HospitalResponse.swift
//  AIDoctor-P Project
//
//  Created by 구본의 on 2021/12/08.
//

import Foundation

struct HospitalResponse: Decodable {
    var isSuccess: Bool
    var code: Int
    var message: String
    var results: [HospitalInfo]
    var radius: Int
    var cnt: Int
}

struct HospitalInfo: Decodable {
    var name: String
    var addr: String
    var phone: String
    var xPos: Float
    var yPos: Float
    var distance: Int
    var hoopUrl: String
    var className: STClass
    var classCode: Int
}
