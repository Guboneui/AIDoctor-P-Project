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
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(UIInputViewController.dismissKeyboard))
        chatTableView.addGestureRecognizer(tap)
        
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
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
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
        
        chatTableView.register(UINib(nibName: "ChatBotTableViewCell", bundle: nil), forCellReuseIdentifier: "ChatBotTableViewCell")
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
        let okButton = UIAlertAction(title: "확인", style: .default, handler: nil)
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
        return 2
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "ChatBotTableViewCell", for: indexPath) as! ChatBotTableViewCell
            cell.selectionStyle = .none
            cell.firstButton.addTarget(self, action: #selector(self.yesAlert), for: .touchUpInside)
            cell.secondButton.addTarget(self, action: #selector(self.noAlert), for: .touchUpInside)
            return cell
            
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "UserChatTableViewCell", for: indexPath) as! UserChatTableViewCell
            cell.selectionStyle = .none
            return cell
            
        }
    }
}
