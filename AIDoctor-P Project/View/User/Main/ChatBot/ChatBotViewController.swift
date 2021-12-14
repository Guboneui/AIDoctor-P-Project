//
//  TestViewController.swift
//  AIDoctor-P Project
//
//  Created by 구본의 on 2021/12/02.
//

import UIKit
import IQKeyboardManager
import Kingfisher
import CoreMIDI
import Combine

protocol WhenViewDisappear: AnyObject{
    func firstTabbarItem()
}

class ChatBotViewController: UIViewController {
    
    var isStart: Bool = false
    
    weak var delegate: WhenViewDisappear?
    
    
    var subscriptions = Set<AnyCancellable>()
    
    @IBOutlet var messageTextField: UITextField!
    @IBOutlet weak var chatTableView: UITableView!
    @IBOutlet weak var chatBaseView: UIView!
    @IBOutlet weak var emergencyButton: UIButton!
    @IBOutlet weak var bottomViewBottomConstraint: NSLayoutConstraint!
    var resetButton: UIBarButtonItem!
    
    override func loadView() {
        super.loadView()
        chatBaseView.layer.cornerRadius = 20
    }
    
    lazy var viewModel: ChatBotViewModel = ChatBotViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setNavigationBar()
        delegate?.firstTabbarItem()
        
        setTableView()
        setKeyboardNotification()
        
        IQKeyboardManager.shared().isEnabled = false
        
        
        self.viewModel.chatView = self
        self.viewModel.getChatStart()
        
        // 뷰모델 채팅 메세지 목록 값 연결
        self.setChatMessagesBinding()
        
        
    }
    
    
    func setKeyboardNotification() {
        
        NotificationCenter.default.addObserver(self, selector: #selector(handleKeyboardShowNotification), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(handleKeyboardHideNotification), name: UIResponder.keyboardWillHideNotification, object: nil)
        
    }
    
    @objc func handleKeyboardShowNotification(_ sender: Notification) {
        
        let userInfo:NSDictionary = sender.userInfo! as NSDictionary
        let keyboardFrame:NSValue = userInfo.value(forKey: UIResponder.keyboardFrameEndUserInfoKey) as! NSValue
        let keyboardRectangle = keyboardFrame.cgRectValue
        let duration = userInfo[UIResponder.keyboardAnimationDurationUserInfoKey]
        
        UIView.animate(withDuration: duration as! TimeInterval) {
            self.bottomViewBottomConstraint.constant = keyboardRectangle.height - 10
            self.view.layoutIfNeeded()
        }
    }
    
    @objc func handleKeyboardHideNotification(_ sender: Notification) {
        
        let userInfo:NSDictionary = sender.userInfo! as NSDictionary
        let duration = userInfo[UIResponder.keyboardAnimationDurationUserInfoKey]
        
        
        UIView.animate(withDuration: duration as! TimeInterval) {
            self.bottomViewBottomConstraint.constant = 0
            self.view.layoutIfNeeded()
        }
    }
    
    
    
    func setNavigationBar() {
        self.title = "AI Doctor"
        
        self.navigationController?.navigationBar.titleTextAttributes = [
            NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 20),
            NSAttributedString.Key.foregroundColor: UIColor(named: "primary2")!
        ]
        
        resetButton = UIBarButtonItem(title: "초기화", style: .done, target: self, action: #selector(resetChatBot))
        resetButton.tintColor = UIColor(named: "primary2")!
        self.navigationItem.rightBarButtonItem = resetButton
        
    }
    
    @objc func resetChatBot() {
        AIDoctorLog.debug("초기화")
        
        let reset: String = "초기화"
        let param = SendChatBotRequest(message: reset)
        let message = SendChatMessage(title: reset, listItem: nil)
        let userMessage = ChatResponse(sender: "user", type: "User", message: message)
        self.viewModel.chatBot.append(userMessage)
        self.viewModel.postChatSend(param)
    }
    
    func setTableView() {
        chatTableView.delegate = self
        chatTableView.dataSource = self
        chatTableView.separatorStyle = .none
        chatTableView.estimatedRowHeight = 100
        chatTableView.rowHeight = UITableView.automaticDimension
        
        
        chatTableView.register(UINib(nibName: "ImageChatBotTableViewCell", bundle: nil), forCellReuseIdentifier: "ImageChatBotTableViewCell")
        chatTableView.register(UINib(nibName: "OnlyImageTableViewCell", bundle: nil), forCellReuseIdentifier: "OnlyImageTableViewCell")
        chatTableView.register(UINib(nibName: "NoneImageChatBotTableViewCell", bundle: nil), forCellReuseIdentifier: "NoneImageChatBotTableViewCell")
        chatTableView.register(UINib(nibName: "UserChatTableViewCell", bundle: nil), forCellReuseIdentifier: "UserChatTableViewCell")
        
        
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        self.tabBarController?.selectedIndex = 0
        IQKeyboardManager.shared().isEnabled = true
    }
    
    
    @IBAction func emergencyButtonAction(_ sender: Any) {
        let alert = UIAlertController(title: "", message: "응급상황이 맞으신가요?\n아닐 경우 사용에 제제가 가해질 수도 있습니다", preferredStyle: .alert)
        let cancelButton = UIAlertAction(title: "취소", style: .default, handler: nil)
        cancelButton.setValue(UIColor(named: "primary2"), forKey: "titleTextColor")
        let okButton = UIAlertAction(title: "확인", style: .default, handler: {_ in
            AIDoctorLog.debug("119 연결 및 병원 관리자 연결이 진행됩니다.")
            let emergencyParam = EmergencyRequest(userId: UserDefaults.standard.integer(forKey: UserDefaultKey.userId))
            self.viewModel.postEmergency(emergencyParam)
            
            if let numberURL = NSURL(string: "tel://" + "010-8749-2753"), UIApplication.shared.canOpenURL(numberURL as URL) {
                UIApplication.shared.open(numberURL as URL, options: [:], completionHandler: nil)
            }
        })
        okButton.setValue(UIColor(named: "primary2"), forKey: "titleTextColor")
        alert.addAction(cancelButton)
        alert.addAction(okButton)
        self.present(alert, animated: true, completion: nil)
    }
    
    @objc func yesAlert() {
        self.presentAlert(title: "Yes")
    }
    
    @objc func noAlert() {
        self.presentAlert(title: "No")
    }
    
    @IBAction func sendMessageButtonAction(_ sender: Any) {
        
        guard let question = self.messageTextField.text?.trim, question.isExists else {
            AIDoctorLog.debug("메세지 창이 비어있습니다.")
            return
        }
        
        let param = SendChatBotRequest(message: question)
        let message = SendChatMessage(title: question, listItem: nil)
        let userMessage = ChatResponse(sender: "user", type: "User", message: message)
        self.viewModel.chatBot.append(userMessage)
        self.viewModel.postChatSend(param)
        
        self.messageTextField.text = nil
    }
    
    
}


extension ChatBotViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.viewModel.chatBot.count + 1
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "ImageChatBotTableViewCell", for: indexPath) as! ImageChatBotTableViewCell
            cell.selectionStyle = .none
            cell.delegate = self
            let url = URL(string: self.viewModel.startBotMessage?.thumbnail ?? "")
            cell.chatBotImage.kf.setImage(with: url)
            
            cell.contentsLabel.attributedText = self.viewModel.startBotMessage?.title.htmlToAttributedStringMethod(font: UIFont.systemFont(ofSize: 16), color: UIColor.black, lineHeight: 1.5)
            
            
            cell.buttonTableViewHeight.constant = CGFloat((viewModel.startBotMessage?.listItem?.count ?? 0) * 40)
            cell.buttonList = self.viewModel.startBotMessage?.listItem ?? []
            
            
            cell.cellIndex = indexPath.row
            
            return cell
            
            
        } else {
            
            let data = self.viewModel.chatBot[indexPath.row - 1]
            
            
            if data.type == "User" {
                let cell = tableView.dequeueReusableCell(withIdentifier: "UserChatTableViewCell", for: indexPath) as! UserChatTableViewCell
                cell.userChatLabel.text = data.message.title
                cell.selectionStyle = .none
                
                return cell
            } else {
                
                if data.type == "TEXT" {
                    if data.message.title.contains("<img") {
                        let cell = tableView.dequeueReusableCell(withIdentifier: "OnlyImageTableViewCell", for: indexPath) as! OnlyImageTableViewCell
                        let startIndex: String.Index = data.message.title.index(data.message.title.startIndex, offsetBy: 10)
                        let endIndex: String.Index = data.message.title.index(data.message.title.endIndex, offsetBy: -2)
                        let imageString = data.message.title[startIndex..<endIndex]
                        let url = URL(string: String(imageString))
                        cell.chatBotImage.kf.setImage(with: url)
                        cell.selectionStyle = .none
                        return cell
                    } else {
                        let cell = tableView.dequeueReusableCell(withIdentifier: "NoneImageChatBotTableViewCell", for: indexPath) as! NoneImageChatBotTableViewCell
                        
                        
                        
                        cell.contentsLabel.attributedText = data.message.title.htmlToAttributedStringMethod(font: UIFont.systemFont(ofSize: 16), color: UIColor.black, lineHeight: 1.5)
                        
                        
                        cell.buttonTableViewHeight.constant = CGFloat((data.message.listItem?.count ?? 0) * 40)
                        cell.buttonList = data.message.listItem ?? []
                        //cell.buttonList = self.viewModel.buttonList?.message.listItem ?? []
                        cell.delegate = self
                        cell.selectionStyle = .none
                        return cell
                    }
                } else if data.type == "SMART_CARD"{
                    let cell = tableView.dequeueReusableCell(withIdentifier: "NoneImageChatBotTableViewCell", for: indexPath) as! NoneImageChatBotTableViewCell
                    cell.contentsLabel.attributedText = data.message.title.htmlToAttributedStringMethod(font: UIFont.systemFont(ofSize: 16), color: UIColor.black, lineHeight: 1.5)
                    cell.buttonTableViewHeight.constant = CGFloat((data.message.listItem?.count ?? 0) * 40)
                    cell.buttonList = data.message.listItem ?? []
                    cell.cellIndex = indexPath.row
                    
                    
                    cell.mainView = self
                    cell.delegate = self
                    cell.selectionStyle = .none
                    return cell
                } else {
                    let cell = tableView.dequeueReusableCell(withIdentifier: "UserChatTableViewCell", for: indexPath) as! UserChatTableViewCell
                    cell.userChatLabel.text = data.message.title
                    cell.selectionStyle = .none
                    return cell
                }
            }
        }
    }
}



extension ChatBotViewController: ChatBotButtonDidSelectedDelegate {
    func chatBotButtonDidSelected(arrayIndex: Int, index: Int) {
        
        
        if self.viewModel.chatBot.count > 1 {
            
            let sendData = self.viewModel.chatBot[arrayIndex - 1]
            let param = SendChatBotRequest(message: sendData.message.listItem![index].value)
            AIDoctorLog.debug("😍 ChatBotViewController - ChatBotButtonDidSelectedDelegate - ChatBotButtonDidSelected")
            let message = SendChatMessage(title: sendData.message.listItem![index].value, listItem: nil)
            if message.title == "네, 호출해주세요." {
                AIDoctorLog.debug("119 연결 및 병원 관리자 연결이 진행됩니다.")
                if let numberURL = NSURL(string: "tel://" + "010-8749-2753"), UIApplication.shared.canOpenURL(numberURL as URL) {
                    UIApplication.shared.open(numberURL as URL, options: [:], completionHandler: nil)
                }
                let emergencyParam = EmergencyRequest(userId: UserDefaults.standard.integer(forKey: UserDefaultKey.userId))
                self.viewModel.postEmergency(emergencyParam)
            }
            let userMessage = ChatResponse(sender: "user", type: "User", message: message)
            self.viewModel.chatBot.append(userMessage)
            self.viewModel.postChatSend(param)
            
        } else {
            
            let param = SendChatBotRequest(message: (self.viewModel.buttonList?.message.listItem![index].value)!)
            AIDoctorLog.debug("😍 ChatBotViewController - ChatBotButtonDidSelectedDelegate - ChatBotButtonDidSelected")
            let message = SendChatMessage(title: (self.viewModel.buttonList?.message.listItem![index].value)!, listItem: nil)
            if message.title == "네, 호출해주세요." {
                AIDoctorLog.debug("119 연결 및 병원 관리자 연결이 진행됩니다.")
                let emergencyParam = EmergencyRequest(userId: UserDefaults.standard.integer(forKey: UserDefaultKey.userId))
                self.viewModel.postEmergency(emergencyParam)
            }
            let userMessage = ChatResponse(sender: "user", type: "User", message: message)
            self.viewModel.chatBot.append(userMessage)
            self.viewModel.postChatSend(param)
        }
    }
}

//MARK: - 콤바인 관련 - 채팅 메세지 목록
extension ChatBotViewController {
    
    
    /// 뷰모델 채팅 메세지목록 바인딩
    fileprivate func setChatMessagesBinding(){
        
        AIDoctorLog.debug("😍 ChatBotViewController - setChatMessagesBinding()")
        self.viewModel.$chatBot.sink{ updatedMessages in
            AIDoctorLog.debug("들어온 데이터 updatedMessages.count: \(updatedMessages.count)")
            
            //            if updatedMessages.count < 2 {
            //                return
            //            }
            //
            //            let indexPath = IndexPath(row: updatedMessages.count, section: 0)
            //
            //            self.chatTableView.scrollToRow(at: indexPath, at: .bottom, animated: true)
            
        }.store(in: &subscriptions)
    }
    
}
