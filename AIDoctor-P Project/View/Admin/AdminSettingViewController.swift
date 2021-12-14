//
//  AdminSettingViewController.swift
//  AIDoctor-P Project
//
//  Created by 구본의 on 2021/12/15.
//

import UIKit

class AdminSettingViewController: UIViewController {

    
    @IBOutlet var chatAlertSwitch: UISwitch!
    @IBOutlet var defaultAlertSwitch: UISwitch!
    
    lazy var logoutViewModel: LogoutViewModel = LogoutViewModel()
    @IBOutlet var logoutButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()

        logoutButton.layer.cornerRadius = 20
        chatAlertSwitch.transform = CGAffineTransform(scaleX: 0.75, y: 0.75)
        defaultAlertSwitch.transform = CGAffineTransform(scaleX: 0.75, y: 0.75)
        self.logoutViewModel.adminSettingView = self
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

extension AdminSettingViewController: LogoutViewModelDelegate {
    func goLoginView() {
        let storyBoard = UIStoryboard(name: "Login", bundle: nil)
        let loginNav = storyBoard.instantiateViewController(identifier: "LoginNav")
        self.changeRootViewController(loginNav)
    }
}

