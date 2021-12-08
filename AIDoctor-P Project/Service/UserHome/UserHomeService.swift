//
//  UserHomeService.swift
//  AIDoctor-P Project
//
//  Created by 구본의 on 2021/12/06.
//

import Foundation

class UserHomeService {
    let repository: UserHomeRepository = UserHomeRepository()
    
    func getDiseaseInfo(onCompleted: @escaping (DiseaseResponse) -> Void, onError: @escaping (String) -> Void) {
        repository.getDiseaseInfo(onCompleted: { response in
            let responseData = DiseaseResponse(isSuccess: response.isSuccess, code: response.code, message: response.message, results: response.results)
            onCompleted(responseData)
            AIDoctorLog.debug("UserHomeService - getDiseaseInfo")
        }, onError: { error in
            onError("UserHomeService - getDiseaseInfo Error: \(error)")
            AIDoctorLog.debug("UserHomeService - getDiseaseInfo Error")
        })
    }
    
    func postHospitalInfo(_ parameters: HospitalRequest, onCompleted: @escaping (HospitalResponse) -> Void, onError: @escaping (String) -> Void) {
        repository.postHospitalInfo(parameters) { response in
            let responseData = HospitalResponse(isSuccess: response.isSuccess, code: response.code, message: response.message, results: response.results, radius: response.radius, cnt: response.cnt)
            onCompleted(responseData)
            AIDoctorLog.debug("UserHomeService - postHospitalInfo")
        } onError: { error in
            onError("UserHomeService - postHospitalInfo Error: \(error)")
            AIDoctorLog.debug("UserHomeService - postHospitalInfo Error")
        }

    }
}
