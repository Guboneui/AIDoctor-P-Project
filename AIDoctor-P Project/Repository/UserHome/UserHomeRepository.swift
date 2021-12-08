//
//  UserHomeRepository.swift
//  AIDoctor-P Project
//
//  Created by 구본의 on 2021/12/06.
//

import Foundation
import Alamofire

class UserHomeRepository {
    func getDiseaseInfo(onCompleted: @escaping (DiseaseResponse) -> Void, onError: @escaping (String) -> Void) {
        AF.request("\(ConstantURL.BASE_URL)/disease", method: .get, headers: nil)
            .validate()
            .responseDecodable(of: DiseaseResponse.self) { response in
                switch response.result {
                    case .success(let response):
                        AIDoctorLog.debug("UserHomeRepository - getDiseaseInfo")
                        onCompleted(response)
                    case .failure(let error):
                        AIDoctorLog.debug("UserHomeRepository - getDiseaseInfo Error: \(error)")
                }
            }
    }
    
    func postHospitalInfo(_ parameters: HospitalRequest, onCompleted: @escaping (HospitalResponse) -> Void, onError: @escaping (String) -> Void) {
        AF.request("\(ConstantURL.BASE_URL)/api/hospital", method: .post, parameters: parameters, encoder: JSONParameterEncoder(), headers: nil)
            .validate()
            .responseDecodable(of: HospitalResponse.self) { response in
                switch response.result {
                case .success(let response):
                    AIDoctorLog.debug("UserHomeRepository - postHospitalInfo")
                    onCompleted(response)
                case .failure(let error):
                    AIDoctorLog.debug("UserHomeRepository - postHospitalInfo Error: \(error)")
                }
            }
    }
}
