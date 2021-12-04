//
//  SecondViewController.swift
//  AIDoctor-P Project
//
//  Created by 구본의 on 2021/12/02.
//

import UIKit

class SecondViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let testVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "TestViewController") as! TestViewController
        testVC.delegate = self
        self.navigationController?.pushViewController(testVC, animated: true)
    }
    
    
}

extension SecondViewController: WhenViewDisappear {
    func firstTabbarItem() {
        print("delegate called")
        self.tabBarController?.selectedIndex = 0
    }
}
