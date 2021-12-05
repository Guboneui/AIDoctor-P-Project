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
            AIDoctorLog.debug("UserHomeService - getDiseaseInfo")
        })
    }
}
