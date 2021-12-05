//
//  DiseaseResponse.swift
//  AIDoctor-P Project
//
//  Created by 구본의 on 2021/12/06.
//

import Foundation

struct DiseaseResponse: Decodable {
    var isSuccess: Bool
    var code: Int
    var message: String
    var results: [DiseaseInfo]?
}

struct DiseaseInfo: Decodable {
    var DIS_ID: Int
    var DIS_NAME: String
    var DIS_SUMMARY: String
    var DIS_SYMPTOM: String
    var DIS_INCUB: String
    var DIS_PREVENT: String
    var DIS_SOLUTION: String
}
