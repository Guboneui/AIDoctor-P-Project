//
//  ChatBotViewModel.swift
//  AIDoctor-P Project
//
//  Created by 구본의 on 2021/12/11.
//

import Foundation

class ChatBotViewModel {
    let chatBotService: ChatBotService = ChatBotService()
    weak var chatView: ChatBotViewController?
    
    var startBotMessage: StartChatResult? {
        didSet {
            chatView?.chatTableView.reloadData()
        }
    }
    
    func getChatStart() {
        chatBotService.getChatStart(onCompleted: { [weak self] response in
            AIDoctorLog.debug("ChatBotViewModel - getChatStart")
            guard let self = self else {return}
            let message = response.message
            let code = response.code
            
            if response.isSuccess == true {
                AIDoctorLog.debug("code: \(code), message: \(message)")
                self.startBotMessage = response.results
            } else {
                AIDoctorLog.debug("code: \(code), message: \(message)")
            }
        }, onError: { error in
            AIDoctorLog.debug("UserHomeViewModel - getChatStart Error: \(error)")
        })
    }
    
    
    
//
//    func getDiseaseInfo() {
//        userHomeService.getDiseaseInfo(onCompleted: { [weak self] response in
//            AIDoctorLog.debug("UserHomeViewModel - getDiseaseInfo")
//            guard let self = self else {return}
//            let message = response.message
//            let code = response.code
//
//            if response.isSuccess == true {
//                AIDoctorLog.debug("code: \(code), message: \(message)")
//                self.diseaseInfo = response.results!
//            } else {
//                AIDoctorLog.debug("code: \(code), message: \(message)")
//            }
//        }, onError: {error in
//            AIDoctorLog.debug("UserHomeViewModel - getDiseaseInfo Error: \(error)")
//
//        })
//    }
}
