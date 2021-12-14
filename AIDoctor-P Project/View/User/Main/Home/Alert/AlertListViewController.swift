//
//  AlertListViewController.swift
//  AIDoctor-P Project
//
//  Created by 구본의 on 2021/12/14.
//

import UIKit

class AlertListViewController: UIViewController {
    
    @IBOutlet var alertListTableView: UITableView!
    
    lazy var viewModel: EmAlertListViewModel = EmAlertListViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setTableView()
        self.title = "알림"
        
        viewModel.alertListView = self
        let param = EmAlertListRequest(userId: UserDefaults.standard.integer(forKey: UserDefaultKey.userId))
        self.viewModel.postEmAlertList(param)
    }
    
    func setTableView() {
        alertListTableView.delegate = self
        alertListTableView.dataSource = self
        alertListTableView.register(UINib(nibName: "AlertListTableViewCell", bundle: nil), forCellReuseIdentifier: "AlertListTableViewCell")
        alertListTableView.separatorStyle = .none
        alertListTableView.estimatedRowHeight = 30
        alertListTableView.rowHeight = UITableView.automaticDimension
    }

}

extension AlertListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.viewModel.alertList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "AlertListTableViewCell", for: indexPath) as! AlertListTableViewCell
        cell.selectionStyle = .none
        
        let data = self.viewModel.alertList[indexPath.row]
        cell.messageLabel.text = data.FCM_CONTENT
        cell.timeLabel.text = data.FCM_DATE
        return cell
    }

}
