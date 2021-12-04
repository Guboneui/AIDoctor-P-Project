//
//  HospitalViewController.swift
//  AIDoctor-P Project
//
//  Created by 구본의 on 2021/12/04.
//

import UIKit

class HospitalViewController: UIViewController {

    @IBOutlet weak var mainTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        setTableView()
        
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
        return cell
    }
    
    
}
