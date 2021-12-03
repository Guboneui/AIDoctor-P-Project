//
//  ThirdViewController.swift
//  AIDoctor-P Project
//
//  Created by 구본의 on 2021/12/02.
//

import UIKit

class ThirdViewController: UIViewController {

    
    @IBOutlet weak var logoutButton: UIButton!
    @IBOutlet weak var chatSwitch: UISwitch!
    @IBOutlet weak var alertSwitch: UISwitch!
    
    override func loadView() {
        super.loadView()
        
        logoutButton.layer.cornerRadius = 20
        chatSwitch.transform = CGAffineTransform(scaleX: 0.75, y: 0.75)
        alertSwitch.transform = CGAffineTransform(scaleX: 0.75, y: 0.75)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

  
}
