//
//  SendAdminMessageService.swift
//  AIDoctor-P Project
//
//  Created by 구본의 on 2021/12/14.
//

import Foundation

class SendAdminMessageService {
    let repository: SendAdminMessageRepository = SendAdminMessageRepository()
    
    func postSendAdminMessage(_ parameters: AdminSendFCMRequest, onCompleted: @escaping (AdminSendFCMResponse) -> Void, onError: @escaping (String) -> Void) {
        repository.postSendAdminMessage(parameters, onCompleted: { response in
            let responseData = AdminSendFCMResponse(isSuccess: response.isSuccess, code: response.code, message: response.message)
            onCompleted(responseData)
            AIDoctorLog.debug("SendAdminMessageService - postSendAdminMessage")
        }, onError: { error in
            onError("SendAdminMessageService - postSendAdminMessage Error: \(error)")
            AIDoctorLog.debug("SendAdminMessageService - postSendAdminMessage Error")
        })
    }
}
