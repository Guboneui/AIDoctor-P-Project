//
//  SendAdminMessageViewModel.swift
//  AIDoctor-P Project
//
//  Created by 구본의 on 2021/12/14.
//

import Foundation

class SendAdminMessageViewModel {
    weak var adminChatView: AdminMainChatViewController?
    let adminService: SendAdminMessageService = SendAdminMessageService()
    
    func postSendAdminMessage(_ parameters: AdminSendFCMRequest) {
        adminService.postSendAdminMessage(parameters, onCompleted: { response in
            AIDoctorLog.debug("SendAdminMessageViewModel - postSendAdminMessage")
            
            let message = response.message
            let code = response.code
            
            if response.isSuccess == true {
                AIDoctorLog.debug("code: \(code), message: \(message)")
                
            } else {
                AIDoctorLog.debug("code: \(code), message: \(message)")
            }
        }, onError: { error in
            AIDoctorLog.debug("SendAdminMessageViewModel - postSendAdminMessage Error: \(error)")
        })
    }
}
