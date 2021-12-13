//
//  EmergencyService.swift
//  AIDoctor-P Project
//
//  Created by 구본의 on 2021/12/14.
//

import Foundation

class EmergencyService {
    let repository: EmergencyRepository = EmergencyRepository()
    
    func postEmergency(_ parameters: EmergencyRequest, onCompleted: @escaping (EmergencyResponse) -> Void, onError: @escaping (String) -> Void) {
        repository.postEmergency(parameters, onCompleted: { response in
            let responseData = EmergencyResponse(isSuccess: response.isSuccess, code: response.code, message: response.message)
            onCompleted(responseData)
            AIDoctorLog.debug("EmergencyService - postEmergency")
        }, onError: { error in
            onError("UserFCMService - postSetToken Error: \(error)")
            AIDoctorLog.debug("EmergencyService - postEmergency")
        })
    }
}
