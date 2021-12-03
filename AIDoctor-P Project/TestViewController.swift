//
//  TestViewController.swift
//  AIDoctor-P Project
//
//  Created by 구본의 on 2021/12/02.
//

import UIKit

protocol WhenViewDisappear: AnyObject{
    func firstTabbarItem()
}

class TestViewController: UIViewController {

    weak var delegate: WhenViewDisappear?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("testView")
        delegate?.firstTabbarItem()

    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        print("viewwilldisappear")
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        print("viewdiddisappear")
        
        self.tabBarController?.selectedIndex = 0
    }


}
