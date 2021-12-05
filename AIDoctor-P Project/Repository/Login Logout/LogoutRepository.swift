//
//  LogoutRepository.swift
//  AIDoctor-P Project
//
//  Created by 구본의 on 2021/12/06.
//

import Foundation
import Alamofire

class LogoutRepository {
    func getLogout(onCompleted: @escaping (LogoutResponse) -> Void, onError: @escaping (String) -> Void) {
        AF.request("\(ConstantURL.BASE_URL)/auth/logout", method: .get, headers: nil)
            .validate()
            .responseDecodable(of: LogoutResponse.self) { response in
                switch response.result {
                    case .success(let response):
                        AIDoctorLog.debug("LogoutRepository - postLogout")
                        onCompleted(response)
                    case .failure(let error):
                        AIDoctorLog.debug("LoginRepository - postLogout Error: \(error)")
                }
            }
    }
}
