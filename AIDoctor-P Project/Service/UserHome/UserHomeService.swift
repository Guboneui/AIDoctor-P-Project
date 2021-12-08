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
        repository.postHospitalInfo(parameters, onCompleted: { response in
            let responseData = HospitalResponse(isSuccess: response.isSuccess, code: response.code, message: response.message, results: response.results, radius: response.radius, cnt: response.cnt)
            onCompleted(responseData)
            AIDoctorLog.debug("UserHomeService - postHospitalInfo")
        }, onError: { error in
            onError("UserHomeService - postHospitalInfo Error: \(error)")
            AIDoctorLog.debug("UserHomeService - postHospitalInfo Error")
        })
    }
    
    func getCovidInfo(onCompleted: @escaping (CovidResponse) -> Void, onError: @escaping (String) -> Void) {
        repository.getCovidInfo(onCompleted: { response in
            let responseData = CovidResponse(isSuccess: response.isSuccess, code: response.code, nessage: response.nessage, results: response.results)
            onCompleted(responseData)
            AIDoctorLog.debug("UserHomeService - getCovidInfo")
        }, onError: { error in
            onError("UserHomeService - getCovidInfo Error: \(error)")
            AIDoctorLog.debug("UserHomeService - getCovidInfo Error")
        })
    }
    
    
    
}
