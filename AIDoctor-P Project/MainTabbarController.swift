//
//  MainTabbarController.swift
//  AIDoctor-P Project
//
//  Created by 구본의 on 2021/12/01.
//

import Foundation
import UIKit

class MainTabbarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        selectedIndex = 1
        self.delegate = self
    }
}

extension MainTabbarController: UITabBarControllerDelegate {
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        print("selected View Controller")
        if selectedIndex == 1 {
            let testVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "TestViewController") as! TestViewController
            testVC.delegate = self
            self.navigationController?.pushViewController(testVC, animated: true)
        }
    }
}


extension MainTabbarController: WhenViewDisappear {
    func firstTabbarItem() {
        print("delegate called")
        self.selectedIndex = 0
    }
}
