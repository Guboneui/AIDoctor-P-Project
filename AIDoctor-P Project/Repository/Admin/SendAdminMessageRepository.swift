//
//  SendAdminMessageRepository.swift
//  AIDoctor-P Project
//
//  Created by 구본의 on 2021/12/14.
//

import Foundation
import Alamofire

class SendAdminMessageRepository {
    func postSendAdminMessage(_ parameters: AdminSendFCMRequest, onCompleted: @escaping (AdminSendFCMResponse) -> Void, onError: (String) -> Void) {
        AF.request("\(ConstantURL.BASE_URL)/fcm/sendFCM", method: .post, parameters: parameters, encoder: JSONParameterEncoder(), headers: nil)
            .validate()
            .responseDecodable(of: AdminSendFCMResponse.self) {response in
                switch response.result {
                case .success(let response):
                    AIDoctorLog.debug("SendAdminMessageRepository - postSendAdminMessage")
                    onCompleted(response)
                case .failure(let error):
                    AIDoctorLog.debug("SendAdminMessageRepository - postSendAdminMessage Error: \(error)")
                }
            }
    }
}
