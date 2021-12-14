//
//  EmAlertListRepository.swift
//  AIDoctor-P Project
//
//  Created by 구본의 on 2021/12/14.
//

import Foundation
import Alamofire

class EmAlertListRepository {
    func postEmAlertList(_ parameters: EmAlertListRequest, onCompleted: @escaping (EmAlertListResponse) -> Void, onError: @escaping (String) -> Void) {
        AF.request("\(ConstantURL.BASE_URL)/fcm/trace", method: .post, parameters: parameters, encoder: JSONParameterEncoder(), headers: nil)
            .validate()
            .responseDecodable(of: EmAlertListResponse.self) { response in
                switch response.result {
                    case .success(let response):
                        AIDoctorLog.debug("EmAlertListRepository - postEmAlertList")
                        onCompleted(response)
                    case .failure(let error):
                        AIDoctorLog.debug("EmAlertListRepository - postEmAlertList Error: \(error)")
                }
            }
    }
    
}
