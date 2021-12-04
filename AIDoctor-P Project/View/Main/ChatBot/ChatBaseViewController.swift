//
//  SecondViewController.swift
//  AIDoctor-P Project
//
//  Created by 구본의 on 2021/12/02.
//

import UIKit

class ChatBaseViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let testVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ChatBotViewController") as! ChatBotViewController
        testVC.delegate = self
        self.navigationController?.pushViewController(testVC, animated: true)
    }
    
    
}

extension ChatBaseViewController: WhenViewDisappear {
    func firstTabbarItem() {
        
        self.tabBarController?.selectedIndex = 0
    }
}
