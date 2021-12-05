//
//  ThirdViewController.swift
//  AIDoctor-P Project
//
//  Created by 구본의 on 2021/12/02.
//

import UIKit

class SettingViewController: UIViewController {

    
    @IBOutlet weak var logoutButton: UIButton!
    @IBOutlet weak var chatSwitch: UISwitch!
    @IBOutlet weak var alertSwitch: UISwitch!
    
    lazy var logoutViewModel: LogoutViewModel = LogoutViewModel()
    
    override func loadView() {
        super.loadView()
        
        logoutButton.layer.cornerRadius = 20
        chatSwitch.transform = CGAffineTransform(scaleX: 0.75, y: 0.75)
        alertSwitch.transform = CGAffineTransform(scaleX: 0.75, y: 0.75)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.logoutViewModel.settingView = self
        self.logoutViewModel.delegate = self
    }
    
    @IBAction func logoutButtonAction(_ sender: Any) {
        let alert = UIAlertController(title: "로그아웃", message: "로그아웃 하시겠어요?", preferredStyle: .alert)
        let cancelButton = UIAlertAction(title: "취소", style: .default, handler: nil)
        let okButton = UIAlertAction(title: "확인", style: .default, handler: {_ in
            self.logoutViewModel.getLogout()
        })
        alert.addAction(cancelButton)
        alert.addAction(okButton)
        self.present(alert, animated: true)
        
    }
}

extension SettingViewController: LogoutViewModelDelegate {
    func goLoginView() {
        let storyBoard = UIStoryboard(name: "Login", bundle: nil)
        let loginNav = storyBoard.instantiateViewController(identifier: "LoginNav")
        self.changeRootViewController(loginNav)
    }
}
