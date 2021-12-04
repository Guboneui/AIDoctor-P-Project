//
//  LoginViewController.swift
//  AIDoctor-P Project
//
//  Created by 구본의 on 2021/12/03.
//

import UIKit

class LoginViewController: UIViewController {

    
    @IBOutlet weak var idBaseView: UIView!
    @IBOutlet weak var idTextField: UITextField!
    @IBOutlet weak var passwordBaseView: UIView!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var passwordResetButton: UIButton!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var signupButton: UIButton!
    

    override func loadView() {
        super.loadView()
        print("test")
        idBaseView.layer.cornerRadius = 10
        idBaseView.layer.borderWidth = 2
        idBaseView.layer.borderColor = UIColor(named: "borderColor")?.cgColor
        idTextField.layer.cornerRadius = 10
        
        passwordBaseView.layer.cornerRadius = 10
        passwordBaseView.layer.borderWidth = 2
        passwordBaseView.layer.borderColor = UIColor(named: "borderColor")?.cgColor
        passwordTextField.layer.cornerRadius = 10
        
        loginButton.layer.cornerRadius = 20
        
    }

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    @IBAction func loginButtonAction(_ sender: Any) {
        AIDoctorLog.debug("로그인")
//        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
//        let mainNav = storyBoard.instantiateViewController(identifier: "MainNav")
//        self.changeRootViewController(mainNav)

//
        let storyBoard = UIStoryboard(name: "Admin", bundle: nil)
        let adminNav = storyBoard.instantiateViewController(identifier: "AdminNav")
        self.changeRootViewController(adminNav)
//
        
    }
}
