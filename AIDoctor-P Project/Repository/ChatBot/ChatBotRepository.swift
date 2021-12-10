//
//  ChatBotRepository.swift
//  AIDoctor-P Project
//
//  Created by 구본의 on 2021/12/11.
//

import Foundation
import Alamofire

class ChatBotRepository {
    func getChatStart(onCompleted: @escaping(StartChatBotResponse) -> Void, onError: (String) -> Void) {
        AF.request("\(ConstantURL.BASE_URL)/api/chatStart", method: .get, headers: nil)
            .validate()
            .responseDecodable(of: StartChatBotResponse.self) { response in
                switch response.result {
                case .success(let response):
                    AIDoctorLog.debug("ChatBotRepository - getChatStart")
                    onCompleted(response)
                case .failure(let error):
                    AIDoctorLog.debug("ChatBotRepository - getChatStart Error: \(error)")
                }
            }
    }
    
    func postChatSend(_ parameters: SendChatBotRequest, onCompleted: @escaping (SendChatBotResponse) -> Void, onError: (String) -> Void) {
        AF.request("\(ConstantURL.BASE_URL)/api/chatSend", method: .post, parameters: parameters, encoder: JSONParameterEncoder(), headers: nil)
            .validate()
            .responseDecodable(of: SendChatBotResponse.self) {response in
                switch response.result {
                case .success(let response):
                    AIDoctorLog.debug("ChatBotRepository - postChatSend")
                    onCompleted(response)
                case .failure(let error):
                    AIDoctorLog.debug("ChatBotRepository - postChatSend Error: \(error)")
                }
            }
    }
}
