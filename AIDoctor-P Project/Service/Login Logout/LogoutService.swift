//
//  LogoutService.swift
//  AIDoctor-P Project
//
//  Created by 구본의 on 2021/12/06.
//

import Foundation

class LogoutService {
    let repository: LogoutRepository = LogoutRepository()
    
    func getLogout(onCompleted: @escaping (LogoutResponse) -> Void, onError: @escaping (String) -> Void) {
        repository.getLogout(onCompleted: { response in
            let responseData = LogoutResponse(isSuccess: response.isSuccess, code: response.code, message: response.message)
            onCompleted(responseData)
            AIDoctorLog.debug("LogoutService - getLogout")
        }, onError: { error in
            onError("LogoutService - postLogout Error: \(error)")
            AIDoctorLog.debug("LogoutService - getLogout")
        })
    }
}
