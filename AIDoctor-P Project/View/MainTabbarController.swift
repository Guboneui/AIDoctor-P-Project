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
        //self.addDotToTabBarItemWith(index: selectedIndex, size: 1.0, color: UIColor(named: "primary2")!)
        setNavigationBar()
    }
    
    func setNavigationBar() {
        let backButton = UIBarButtonItem()
        backButton.title = ""
        self.navigationController?.navigationBar.topItem?.backBarButtonItem = backButton
    }
}

extension MainTabbarController: UITabBarControllerDelegate {
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        if selectedIndex == 1 {
            let testVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ChatBotViewController") as! ChatBotViewController
            testVC.delegate = self
            self.navigationController?.pushViewController(testVC, animated: true)
        }
    }
}

extension MainTabbarController: WhenViewDisappear {
    func firstTabbarItem() {
        self.selectedIndex = 0
    }
}
