//
//  EmergencyRepository.swift
//  AIDoctor-P Project
//
//  Created by 구본의 on 2021/12/14.
//

import Foundation
import Alamofire

class EmergencyRepository{
    func postEmergency(_ parameters: EmergencyRequest, onCompleted: @escaping (EmergencyResponse) -> Void, onError: @escaping (String) -> Void) {
        AF.request("\(ConstantURL.BASE_URL)/fcm/emergency", method: .post, parameters: parameters, encoder: JSONParameterEncoder(), headers: nil)
            .validate()
            .responseDecodable(of: EmergencyResponse.self) { response in
                switch response.result {
                    case .success(let response):
                        AIDoctorLog.debug("EmergencyRepository - postEmergency")
                        onCompleted(response)
                    case .failure(let error):
                        AIDoctorLog.debug("EmergencyRepository - postEmergency Error: \(error)")
                }
            }
    }
}
