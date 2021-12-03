//
//  DiseaseViewController.swift
//  AIDoctor-P Project
//
//  Created by 구본의 on 2021/12/04.
//

import UIKit

class DiseaseViewController: UIViewController {

    @IBOutlet weak var mainTableView: UITableView!
    
    var navTitle: String = "인플루엔자"
    
    override func loadView() {
        super.loadView()
        self.mainTableView.layer.cornerRadius = 50
        mainTableView.layer.maskedCorners = CACornerMask(arrayLiteral: .layerMinXMinYCorner)
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setNavigationBar()
        setTableView()
    }
    
    func setNavigationBar() {
        self.title = self.navTitle
        
        self.navigationController?.navigationBar.titleTextAttributes = [
            NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 20),
            NSAttributedString.Key.foregroundColor: UIColor(named: "primary2")!
        ]
    }
    
    func setTableView() {
        mainTableView.delegate = self
        mainTableView.dataSource = self
        mainTableView.separatorStyle = .none
        mainTableView.estimatedRowHeight = 50
        mainTableView.rowHeight = UITableView.automaticDimension
        mainTableView.register(UINib(nibName: "DiscriptionTableViewCell", bundle: nil), forCellReuseIdentifier: "DiscriptionTableViewCell")
        mainTableView.register(UINib(nibName: "SymptomTableViewCell", bundle: nil), forCellReuseIdentifier: "SymptomTableViewCell")
        mainTableView.register(UINib(nibName: "RouteTableViewCell", bundle: nil), forCellReuseIdentifier: "RouteTableViewCell")
        mainTableView.register(UINib(nibName: "IncubationPeriodTableViewCell", bundle: nil), forCellReuseIdentifier: "IncubationPeriodTableViewCell")
        mainTableView.register(UINib(nibName: "PreventionTableViewCell", bundle: nil), forCellReuseIdentifier: "PreventionTableViewCell")
        
        
        
        
    }
}

extension DiseaseViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "DiscriptionTableViewCell", for: indexPath) as! DiscriptionTableViewCell
            return cell
        } else if indexPath.row == 1{
            let cell = tableView.dequeueReusableCell(withIdentifier: "SymptomTableViewCell", for: indexPath) as! SymptomTableViewCell
            return cell
            
        } else if indexPath.row == 2 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "RouteTableViewCell", for: indexPath) as! RouteTableViewCell
            return cell
            
        } else if indexPath.row == 3{
            let cell = tableView.dequeueReusableCell(withIdentifier: "IncubationPeriodTableViewCell", for: indexPath) as! IncubationPeriodTableViewCell
            return cell
            
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "PreventionTableViewCell", for: indexPath) as! PreventionTableViewCell
            return cell
            
        }
       
    }
    
    
}


