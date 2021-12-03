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
        self.addDotToTabBarItemWith(index: selectedIndex, size: 1.0, color: UIColor(named: "primary2")!)
    }
    
    func addDotToTabBarItemWith(index: Int,size: CGFloat,color: UIColor, verticalOffset: CGFloat = 1.0) {

            // set distance from tab bar icons
             for tabItem in self.viewControllers! {
                tabItem.tabBarItem.titlePositionAdjustment = UIOffset(horizontal: 0.0, vertical: verticalOffset)
            }

            // set default appearance for tabbar icon title
        UITabBarItem.appearance().setTitleTextAttributes([NSAttributedString.Key.foregroundColor: color,NSAttributedString.Key.font:UIFont(name: "American Typewriter", size: size)!], for: .normal)
        UITabBarItem.appearance().setTitleTextAttributes([NSAttributedString.Key.foregroundColor: color,NSAttributedString.Key.font:UIFont(name: "American Typewriter", size: size)!], for: .selected)

            // place the dot
            guard let vc = self.viewControllers?[index] else {
                //log.error("Couldn't find a TabBar Controller with index:\(index)")
                return
            }

            vc.tabBarItem.title = "•"
        }
    
    
}

extension MainTabbarController: UITabBarControllerDelegate {
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        print("selected View Controller")
//        if selectedIndex == 1 {
//            let testVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "TestViewController") as! TestViewController
//            testVC.delegate = self
//            self.navigationController?.pushViewController(testVC, animated: true)
//        }
    }
}


extension MainTabbarController: WhenViewDisappear {
    func firstTabbarItem() {
        print("delegate called")
        self.selectedIndex = 0
    }
}
