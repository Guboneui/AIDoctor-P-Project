//
//  AdminMainChatViewController.swift
//  AIDoctor-P Project
//
//  Created by 구본의 on 2021/12/05.
//

import UIKit
import IQKeyboardManager

class AdminMainChatViewController: UIViewController {

    
    
    
    @IBOutlet var messageTextField: UITextField!
    @IBOutlet var mainTableView: UITableView!
    @IBOutlet var messageBaseView: UIView!
    @IBOutlet var bottomViewBottomConstraint: NSLayoutConstraint!
    
    lazy var viewModel: SendAdminMessageViewModel = SendAdminMessageViewModel()
    
    override func loadView() {
        super.loadView()
        self.messageBaseView.layer.cornerRadius = 20
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setTableView()
        setNavigationBar()
        setKeyboardNotification()
        IQKeyboardManager.shared().isEnabled = false
        
        self.viewModel.adminChatView = self
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        IQKeyboardManager.shared().isEnabled = true
    }
    
    
    func setNavigationBar() {
        self.title = "AI Doctor"
        
        self.navigationController?.navigationBar.titleTextAttributes = [
            NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 20),
            NSAttributedString.Key.foregroundColor: UIColor(named: "primary2")!
        ]
    }
    
    func setTableView() {
        mainTableView.delegate = self
        mainTableView.dataSource = self
        mainTableView.separatorStyle = .none
        mainTableView.register(UINib(nibName: "AdminMainChatTableViewCell", bundle: nil), forCellReuseIdentifier: "AdminMainChatTableViewCell")
    }
    
    
    func setKeyboardNotification() {
        
        NotificationCenter.default.addObserver(self, selector: #selector(handleKeyboardShowNotification), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(handleKeyboardHideNotification), name: UIResponder.keyboardWillHideNotification, object: nil)
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(UIInputViewController.dismissKeyboard))
        mainTableView.addGestureRecognizer(tap)
        
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
    
    @IBAction func sendButtonAction(_ sender: Any) {
        guard let adminMessage = self.messageTextField.text?.trim, adminMessage.isExists else {
            AIDoctorLog.debug("메세지 창이 비어있습니다.")
            return
        }
        let param = AdminSendFCMRequest(userId: 1, message: adminMessage)
        self.viewModel.postSendAdminMessage(param)
    }
    
}


extension AdminMainChatViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "AdminMainChatTableViewCell", for: indexPath) as! AdminMainChatTableViewCell
        cell.selectionStyle = .none
        return cell
    }
    
    
}
