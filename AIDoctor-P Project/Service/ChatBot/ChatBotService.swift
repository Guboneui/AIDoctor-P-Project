//
//  ChatBotService.swift
//  AIDoctor-P Project
//
//  Created by 구본의 on 2021/12/11.
//

import Foundation

class ChatBotService {
    let repository: ChatBotRepository = ChatBotRepository()
    
    func getChatStart(onCompleted: @escaping (StartChatBotResponse) -> Void, onError: @escaping (String) -> Void) {
        repository.getChatStart(onCompleted: { response in
            let responseData = StartChatBotResponse(isSuccess: response.isSuccess, code: response.code, message: response.message, results: response.results)
            onCompleted(responseData)
            AIDoctorLog.debug("ChatBotService - getChatStart")
        }, onError: { error in
            onError("ChatBotService - getChatStart Error: \(error)")
            AIDoctorLog.debug("ChatBotService - getChatStart Error")
        })
    }
    
    
    func postChatSend(_ parameters: SendChatBotRequest, onCompleted: @escaping (SendChatBotResponse) -> Void, onError: @escaping (String) -> Void) {
        repository.postChatSend(parameters, onCompleted: { response in
            let responseData = SendChatBotResponse(isSuccess: response.isSuccess, code: response.code, message: response.message, results: response.results)
            onCompleted(responseData)
            AIDoctorLog.debug("ChatBotService - postChatSend")
        }, onError: { error in
            onError("ChatBotService - postChatSend Error: \(error)")
            AIDoctorLog.debug("ChatBotService - postChatSend Error")
        })
    }
    

}
