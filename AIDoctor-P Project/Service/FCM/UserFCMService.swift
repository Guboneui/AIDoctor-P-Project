//
//  UserFCMService.swift
//  AIDoctor-P Project
//
//  Created by 구본의 on 2021/12/14.
//

import Foundation

class UserFCMService {
    let repository: UserFCMRepository = UserFCMRepository()
    
    func postSetToken(_ parameters: SetTokenRequest, onCompleted: @escaping (SetTokenResponse) -> Void, onError: @escaping (String) -> Void) {
        repository.postSetToken(parameters, onCompleted: { response in
            let responseData = SetTokenResponse(isSuccess: response.isSuccess, code: response.code, message: response.message)
            onCompleted(responseData)
            AIDoctorLog.debug("UserFCMService - postSetToken")
        }, onError: { error in
            onError("UserFCMService - postSetToken Error: \(error)")
            AIDoctorLog.debug("UserFCMService - postSetToken")
        })
    }
    
    func postDeleteToken(_ parameters: DeleteTokenRequest, onCompleted: @escaping (DeleteTokenResponse) -> Void, onError: @escaping (String) -> Void) {
        repository.postDeleteToken(parameters, onCompleted: { response in
            let responseData = DeleteTokenResponse(isSuccess: response.isSuccess, code: response.code, message: response.message)
            onCompleted(responseData)
            AIDoctorLog.debug("UserFCMService - postDeleteToken")
        }, onError: { error in
            onError("UserFCMService - postDeleteToken Error: \(error)")
            AIDoctorLog.debug("UserFCMService - postDeleteToken")
        })
    }
}
