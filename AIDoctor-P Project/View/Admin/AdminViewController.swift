//
//  AdminViewController.swift
//  AIDoctor-P Project
//
//  Created by 구본의 on 2021/12/05.
//

import UIKit

class AdminViewController: UIViewController {

    @IBOutlet var searchBaseView: UIView!
    @IBOutlet var mainTableView: UITableView!
    
    override func loadView() {
        super.loadView()
        searchBaseView.layer.cornerRadius = 20
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setTableView()
    }
    
    func setTableView() {
        self.mainTableView.delegate = self
        self.mainTableView.dataSource = self
        self.mainTableView.separatorStyle = .none
        self.mainTableView.register(UINib(nibName: "AdminChatTableViewCell", bundle: nil), forCellReuseIdentifier: "AdminChatTableViewCell")
        let footerView = UIView(frame: CGRect(x: 0, y: 0, width: self.mainTableView.frame.width, height: 40))
        footerView.backgroundColor = .white
        self.mainTableView.tableFooterView = footerView
    }
    


}

extension AdminViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "AdminChatTableViewCell", for: indexPath) as! AdminChatTableViewCell
        cell.selectionStyle = .none
        return cell
    }
    
    
}
