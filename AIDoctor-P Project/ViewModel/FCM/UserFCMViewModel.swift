//
//  UserFCMViewModel.swift
//  AIDoctor-P Project
//
//  Created by 구본의 on 2021/12/14.
//

import Foundation

class UserFCMViewModel {
    weak var loginView: LoginViewController?
    let userFCMService = UserFCMService()
    
    
    func postSetToken(_ parameters: SetTokenRequest) {
        userFCMService.postSetToken(parameters, onCompleted: { [weak self] response in
            AIDoctorLog.debug("UserFCMViewModel - postSetToken")
            guard let self = self else {return}
            let message = response.message
            let code = response.code
            
            if response.isSuccess == true {
                AIDoctorLog.debug("code: \(code), message: \(message)")
                
            } else {
                AIDoctorLog.debug("code: \(code), message: \(message)")
            }
        }, onError: {error in
            AIDoctorLog.debug("UserFCMViewModel - postSetToken Error: \(error)")
            AIDoctorLog.debug("UserFCMViewModel - postSetToken")
        })
    }
}
