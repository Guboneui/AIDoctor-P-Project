//
//  UserFCMRepository.swift
//  AIDoctor-P Project
//
//  Created by 구본의 on 2021/12/14.
//

import Foundation
import Alamofire

class UserFCMRepository {
    func postSetToken(_ parameters: SetTokenRequest, onCompleted: @escaping (SetTokenResponse) -> Void, onError: @escaping (String) -> Void) {
        AF.request("\(ConstantURL.BASE_URL)/fcm/setToken", method: .post, parameters: parameters, encoder: JSONParameterEncoder(), headers: nil)
            .validate()
            .responseDecodable(of: SetTokenResponse.self) { response in
                switch response.result {
                    case .success(let response):
                        AIDoctorLog.debug("UserFCMRepository - postSetToken")
                        onCompleted(response)
                    case .failure(let error):
                        AIDoctorLog.debug("UserFCMRepository - postSetToken Error: \(error)")
                }
            }
    }
    
    func postDeleteToken(_ parameters: DeleteTokenRequest, onCompleted: @escaping (DeleteTokenResponse) -> Void, onError: @escaping (String) -> Void) {
        AF.request("\(ConstantURL.BASE_URL)/fcm/deleteToken", method: .post, parameters: parameters, encoder: JSONParameterEncoder(), headers: nil)
            .validate()
            .responseDecodable(of: DeleteTokenResponse.self) { response in
                switch response.result {
                    case .success(let response):
                        AIDoctorLog.debug("UserFCMRepository - postDeleteToken")
                        onCompleted(response)
                    case .failure(let error):
                        AIDoctorLog.debug("UserFCMRepository - postDeleteToken Error: \(error)")
                }
            }
    }
}
