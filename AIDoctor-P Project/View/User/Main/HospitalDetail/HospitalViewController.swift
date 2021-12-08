//
//  HospitalViewController.swift
//  AIDoctor-P Project
//
//  Created by 구본의 on 2021/12/04.
//

import UIKit

class HospitalViewController: UIViewController {

    @IBOutlet weak var mainTableView: UITableView!
    
    var hospitalInfo: HospitalInfo?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setTableView()
        setNavigationBar()

    }
    
    func setNavigationBar() {
        self.title = self.hospitalInfo?.name
        
        self.navigationController?.navigationBar.titleTextAttributes = [
            NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 20),
            NSAttributedString.Key.foregroundColor: UIColor(named: "primary2")!
        ]
    }
    
    func setTableView() {
        mainTableView.delegate = self
        mainTableView.dataSource = self
        mainTableView.register(UINib(nibName: "HospitalDetailTableViewCell", bundle: nil), forCellReuseIdentifier: "HospitalDetailTableViewCell")
        mainTableView.estimatedRowHeight = 300
        mainTableView.rowHeight = UITableView.automaticDimension
    }
}

extension HospitalViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "HospitalDetailTableViewCell", for: indexPath) as! HospitalDetailTableViewCell
        cell.selectionStyle = .none
        cell.nameLabel.text = self.hospitalInfo?.name
        cell.linkLabel.text = "홈페이지: \(self.hospitalInfo?.hospUrl ?? "정보 없음")"
        cell.phoneNumberLabel.text = self.hospitalInfo?.phone
        cell.locationLabel.text = self.hospitalInfo?.addr
        cell.xPos = self.hospitalInfo!.xPos
        
        cell.yPos = self.hospitalInfo!.yPos
        return cell
    }
}
