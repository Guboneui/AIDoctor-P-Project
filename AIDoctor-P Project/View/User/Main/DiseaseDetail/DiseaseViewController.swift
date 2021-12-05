//
//  DiseaseViewController.swift
//  AIDoctor-P Project
//
//  Created by 구본의 on 2021/12/04.
//

import UIKit

class DiseaseViewController: UIViewController {

    @IBOutlet weak var mainTableView: UITableView!
    
   
    
    var diseaseInfo: DiseaseInfo?
    
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
        self.title = self.diseaseInfo?.DIS_NAME
        
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
            cell.descriptionLabel.text = self.diseaseInfo?.DIS_SUMMARY
            return cell
        } else if indexPath.row == 1{
            let cell = tableView.dequeueReusableCell(withIdentifier: "SymptomTableViewCell", for: indexPath) as! SymptomTableViewCell
            cell.symptomLabel.text = self.diseaseInfo?.DIS_SYMPTOM
            return cell
            
        } else if indexPath.row == 2 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "RouteTableViewCell", for: indexPath) as! RouteTableViewCell
            cell.routeLabel.text = self.diseaseInfo?.DIS_ROUTE
            return cell
            
        } else if indexPath.row == 3{
            let cell = tableView.dequeueReusableCell(withIdentifier: "IncubationPeriodTableViewCell", for: indexPath) as! IncubationPeriodTableViewCell
            cell.incubLabel.text = self.diseaseInfo?.DIS_INCUB
            return cell
            
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "PreventionTableViewCell", for: indexPath) as! PreventionTableViewCell
            cell.preventionLabel.text = self.diseaseInfo?.DIS_PREVENT
            return cell
            
        }
    }
}


