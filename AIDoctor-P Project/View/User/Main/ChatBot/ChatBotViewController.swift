//
//  TestViewController.swift
//  AIDoctor-P Project
//
//  Created by 구본의 on 2021/12/02.
//

import UIKit
import IQKeyboardManager
import Kingfisher

protocol WhenViewDisappear: AnyObject{
    func firstTabbarItem()
}


class ChatBotViewController: UIViewController {
    
    weak var delegate: WhenViewDisappear?
    
    @IBOutlet var messageTextField: UITextField!
    @IBOutlet weak var chatTableView: UITableView!
    @IBOutlet weak var chatBaseView: UIView!
    @IBOutlet weak var emergencyButton: UIButton!
    @IBOutlet weak var bottomViewBottomConstraint: NSLayoutConstraint!
    
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
    }
    
    func setTableView() {
        chatTableView.delegate = self
        chatTableView.dataSource = self
        chatTableView.separatorStyle = .none
        chatTableView.estimatedRowHeight = 100
        chatTableView.rowHeight = UITableView.automaticDimension
        
        
        chatTableView.register(UINib(nibName: "ImageChatBotTableViewCell", bundle: nil), forCellReuseIdentifier: "ImageChatBotTableViewCell")
        chatTableView.register(UINib(nibName: "NoneImageChatBotTableViewCell", bundle: nil), forCellReuseIdentifier: "NoneImageChatBotTableViewCell")
        chatTableView.register(UINib(nibName: "UserChatTableViewCell", bundle: nil), forCellReuseIdentifier: "UserChatTableViewCell")
        
        UIView.animate(withDuration: 0, delay: 0, options: .curveEaseOut, animations: {
            self.view.layoutIfNeeded()
        }, completion: {(completed) in
            let indexPath = IndexPath(row: 2, section: 0)
            //self.chatTableView.scrollToRow(at: indexPath, at: .bottom, animated: false)
        })
        
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
//            if let numberURL = NSURL(string: "tel://" + "119"), UIApplication.shared.canOpenURL(numberURL as URL) {
//                UIApplication.shared.open(numberURL as URL, options: [:], completionHandler: nil)
//            }
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
            print("메세지창이 비어있습니다.")
            return
        }
        
        let param = SendChatBotRequest(message: question)
        let message = SendChatMessage(title: question, listItem: nil)
        let userMessage = ChatResponse(sender: "user", type: "Text", message: message)
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
            let font = UIFont.systemFont(ofSize: 16)
            cell.contentsLabel.attributedText = self.viewModel.startBotMessage?.title.htmlEscaped(font: font, colorHex: "#000000", lineSpacing: 1.5)
            
            cell.buttonTableViewHeight.constant = CGFloat((viewModel.startBotMessage?.listItem?.count ?? 0) * 40)
            cell.buttonList = self.viewModel.startBotMessage?.listItem ?? []
            
            
            return cell
            
            
        } else {
            
            let data = self.viewModel.chatBot[indexPath.row - 1]
            
            if data.sender == "user" {
                let cell = tableView.dequeueReusableCell(withIdentifier: "UserChatTableViewCell", for: indexPath) as! UserChatTableViewCell
                cell.userChatLabel.text = data.message.title
                cell.selectionStyle = .none
                
                return cell
            } else {
                
                if data.message.title.contains("png") {
                    let cell = tableView.dequeueReusableCell(withIdentifier: "ImageChatBotTableViewCell", for: indexPath) as! ImageChatBotTableViewCell
                    let startIndex: String.Index = data.message.title.index(data.message.title.startIndex, offsetBy: 10)
                    let endIndex: String.Index = data.message.title.index(data.message.title.endIndex, offsetBy: -2)
                    let imageString = data.message.title[startIndex..<endIndex]
                    print("🤯imageString: \(imageString)")
                    let url = URL(string: String(imageString))
                    cell.chatBotImage.kf.setImage(with: url)
                    cell.contentsLabel.text = ""
                    //let font = UIFont.systemFont(ofSize: 16)
                    //cell.contentsLabel.attributedText = data.message.title.htmlEscaped(font: font, colorHex: "#000000", lineSpacing: 1.5)
                    
                    cell.buttonTableViewHeight.constant = CGFloat((data.message.listItem?.count ?? 0) * 40)
                    //cell.buttonList = self.viewModel.startBotMessage?.listItem ?? []
                    
                    cell.sendButtonList = data.message.listItem ?? []
                    
                    return cell
                }
                
                
                
                else if data.message.title.contains("<img") || data.message.title.contains("jpg") {
                    let cell = tableView.dequeueReusableCell(withIdentifier: "ImageChatBotTableViewCell", for: indexPath) as! ImageChatBotTableViewCell
                    let startIndex: String.Index = data.message.title.index(data.message.title.startIndex, offsetBy: 10)
                    let endIndex: String.Index = data.message.title.index(data.message.title.endIndex, offsetBy: -2)
                    let imageString = data.message.title[startIndex..<endIndex]
                    print("🤯imageString: \(imageString)")
                    let url = URL(string: String(imageString))
                    cell.chatBotImage.kf.setImage(with: url)
                    cell.contentsLabel.text = ""
                    //let font = UIFont.systemFont(ofSize: 16)
                    //cell.contentsLabel.attributedText = data.message.title.htmlEscaped(font: font, colorHex: "#000000", lineSpacing: 1.5)
                    
                    cell.buttonTableViewHeight.constant = CGFloat((data.message.listItem?.count ?? 0) * 40)
                    //cell.buttonList = self.viewModel.startBotMessage?.listItem ?? []
                    
                    cell.sendButtonList = data.message.listItem ?? []
                    
                    return cell
                }
                
                
                
                else {
                    let cell = tableView.dequeueReusableCell(withIdentifier: "NoneImageChatBotTableViewCell", for: indexPath) as! NoneImageChatBotTableViewCell
                    let font = UIFont.systemFont(ofSize: 16)
                    cell.contentsLabel.attributedText = data.message.title.htmlEscaped(font: font, colorHex: "#000000", lineSpacing: 1.5)
                    
                    cell.buttonTableViewHeight.constant = CGFloat((data.message.listItem?.count ?? 0) * 40)
                    cell.buttonList = data.message.listItem ?? []
                    
                    cell.selectionStyle = .none
                    return cell
                }
                
                
                
               
                
                
                
             
            }
            
            
            
            
            
            
        }
    }
}

extension ChatBotViewController: ChatBotButtonDidSelectedDelegate {
    func chatBotButtonDidSelected(index: Int) {
        UIView.animate(withDuration: 0, delay: 0, options: .curveEaseOut, animations: {
            self.view.layoutIfNeeded()
        }, completion: {(completed) in
            let indexPath = IndexPath(row: self.viewModel.chatBot.count, section: 0)
            self.chatTableView.scrollToRow(at: indexPath, at: .bottom, animated: false)
        })
        
        let param = SendChatBotRequest(message: (self.viewModel.startBotMessage?.listItem![index].value)!)
        let message = SendChatMessage(title: (self.viewModel.startBotMessage?.listItem![index].value)!, listItem: nil)
        let userMessage = ChatResponse(sender: "user", type: "Text", message: message)
        self.viewModel.chatBot.append(userMessage)
        self.viewModel.postChatSend(param)
    }
}

