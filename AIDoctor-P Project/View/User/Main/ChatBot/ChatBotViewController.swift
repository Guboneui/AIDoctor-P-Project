//
//  TestViewController.swift
//  AIDoctor-P Project
//
//  Created by 구본의 on 2021/12/02.
//

import UIKit
import IQKeyboardManager

protocol WhenViewDisappear: AnyObject{
    func firstTabbarItem()
}




class ChatBotViewController: UIViewController {
    
    weak var delegate: WhenViewDisappear?
    
    @IBOutlet weak var chatTableView: UITableView!
    @IBOutlet weak var chatBaseView: UIView!
    @IBOutlet weak var emergencyButton: UIButton!
    @IBOutlet weak var bottomViewBottomConstraint: NSLayoutConstraint!
    
    override func loadView() {
        super.loadView()
        chatBaseView.layer.cornerRadius = 20
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setNavigationBar()
        delegate?.firstTabbarItem()
        
        setTableView()
        setKeyboardNotification()
        
        IQKeyboardManager.shared().isEnabled = false
        
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
            self.chatTableView.scrollToRow(at: indexPath, at: .bottom, animated: false)
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
}


extension ChatBotViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "ImageChatBotTableViewCell", for: indexPath) as! ImageChatBotTableViewCell
            cell.selectionStyle = .none
            cell.delegate = self
            cell.buttonTableViewHeight.constant = 40 * 5
            return cell
            
            
        } else if indexPath.row == 1 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "NoneImageChatBotTableViewCell", for: indexPath) as! NoneImageChatBotTableViewCell
            cell.selectionStyle = .none
            cell.delegate = self
            cell.buttonTableViewHeight.constant = 40 * 3
            return cell
            
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "UserChatTableViewCell", for: indexPath) as! UserChatTableViewCell
            cell.selectionStyle = .none
            return cell
            
        }
    }
}

extension ChatBotViewController: ChatBotButtonDidSelectedDelegate {
    func chatBotButtonDidSelected() {
        UIView.animate(withDuration: 0, delay: 0, options: .curveEaseOut, animations: {
            self.view.layoutIfNeeded()
        }, completion: {(completed) in
            let indexPath = IndexPath(row: 2, section: 0)
            self.chatTableView.scrollToRow(at: indexPath, at: .bottom, animated: false)
        })
    }
}

