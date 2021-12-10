//
//  ChatBotViewModel.swift
//  AIDoctor-P Project
//
//  Created by 구본의 on 2021/12/11.
//

import Foundation

struct ChatResponse {
    var sender: String
    var type: String
    var message: SendChatMessage
}

class ChatBotViewModel {
    let chatBotService: ChatBotService = ChatBotService()
    weak var chatView: ChatBotViewController?
    
    var startBotMessage: StartChatResult? {
        didSet {
            chatView?.chatTableView.reloadData()
        }
    }
    
    var sendBotMessage: [SendChatResults] = [] {
        didSet {
            //print(sendBotMessage)
        }
    }
    
    
    var chatBot: [ChatResponse] = [] {
        didSet {
            self.chatView?.chatTableView.reloadData()
            UIView.animate(withDuration: 0, delay: 0, options: .curveEaseOut, animations: {
                self.chatView?.view.layoutIfNeeded()
            }, completion: {(completed) in
                let indexPath = IndexPath(row: self.chatBot.count, section: 0)
                self.chatView?.chatTableView.scrollToRow(at: indexPath, at: .bottom, animated: false)
            })
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
    
    
    func postChatSend(_ parameters: SendChatBotRequest) {
        chatBotService.postChatSend(parameters) { [weak self] response in
            AIDoctorLog.debug("ChatBotViewModel - postChatSend")
            guard let self = self else {return}
            let message = response.message
            let code = response.code
            
            if response.isSuccess == true {
                AIDoctorLog.debug("code: \(code), message: \(message)")
                
                for i in 0..<response.results!.count {
                    let data = response.results![i]
                    let chatData = ChatResponse(sender: "chatBot", type: data.type, message: data.message)
                    //print("chatData: \(chatData)")
                    self.chatBot.append(chatData)
                    
                }
                
                print(self.chatBot)
                
                
                //let data = test(sender: "chatBot", type: response.results, message: <#T##SendChatMessage?#>)
                self.sendBotMessage = response.results!
            } else {
                AIDoctorLog.debug("code: \(code), message: \(message)")
            }
        } onError: { error in
            AIDoctorLog.debug("ChatBotViewModel - postChatSend Error: \(error)")
        }
    }

}
