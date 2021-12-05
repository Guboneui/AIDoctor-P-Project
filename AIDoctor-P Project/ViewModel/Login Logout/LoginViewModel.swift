//
//  LoginViewModel.swift
//  AIDoctor-P Project
//
//  Created by 구본의 on 2021/12/06.
//

import Foundation

protocol LoginViewModelDelegate: AnyObject {
    func goMainView(isAdmin: Int)
}

class LoginViewModel {
    weak var loginView: LoginViewController?
    let loginSerivce = LoginService()
    weak var delegate: LoginViewModelDelegate?
    func postLogin(_ parameters: LoginRequest) {
        loginSerivce.postLogin(parameters, onCompleted: { [weak self] response in
            AIDoctorLog.debug("LoginViewModel - postLogin")
            guard let self = self else {return}
            let message = response.message
            let code = response.code
            
            if response.isSuccess == true {
                AIDoctorLog.debug("code: \(code), message: \(message)")
                let isAdmin = response.user?.USER_ISADMIN
                self.delegate?.goMainView(isAdmin: isAdmin ?? 0)
                
            } else {
                AIDoctorLog.debug("code: \(code), message: \(message)")
            }
        }, onError: {error in
            AIDoctorLog.debug("LoginViewModel - postLogin Error: \(error)")
            AIDoctorLog.debug("LoginViewModel - postLogin")
        })
    }
}
