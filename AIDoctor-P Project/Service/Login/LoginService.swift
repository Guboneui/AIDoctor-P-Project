//
//  LoginService.swift
//  AIDoctor-P Project
//
//  Created by 구본의 on 2021/12/06.
//

import Foundation

class LoginService {
    let repository: LoginRepository = LoginRepository()
    
    func postLogin(_ parameters: LoginRequest, onCompleted: @escaping (LoginResponse) -> Void, onError: @escaping (String) -> Void) {
        repository.postLogin(parameters, onCompleted: { response in
            let responseData = LoginResponse(isSuccess: response.isSuccess, code: response.code, message: response.message, user: response.user)
            onCompleted(responseData)
            
        }, onError: { error in
            onError("LoginService - postLogin Error: \(error)")
        })
    }
}
