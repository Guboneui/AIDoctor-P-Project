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
    
    lazy var viewModel: AdminHomeViewModel = AdminHomeViewModel()
    
    override func loadView() {
        super.loadView()
        searchBaseView.layer.cornerRadius = 20
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setNavigationBar()
        setTableView()
        self.viewModel.adminMain = self
        self.viewModel.getEmList()
    }
    
    func setNavigationBar() {
        let backButton = UIBarButtonItem()
        backButton.title = ""
        self.navigationController?.navigationBar.topItem?.backBarButtonItem = backButton
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
    
    @IBAction func adminSettingButtonAction(_ sender: Any) {
        let storyBoard = UIStoryboard(name: "Admin", bundle: nil)
        let settingVC = storyBoard.instantiateViewController(withIdentifier: "AdminSettingViewController") as! AdminSettingViewController
        
        self.navigationController?.pushViewController(settingVC, animated: true)
    }
    
}

extension AdminViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.viewModel.emList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "AdminChatTableViewCell", for: indexPath) as! AdminChatTableViewCell
        cell.selectionStyle = .none
        let data = self.viewModel.emList[indexPath.row]
        cell.userNameLabel.text = data.USER_USERID
        
        let formatter = DateFormatter()
        formatter.dateFormat = "a hh:mm"
        let current_date_string = formatter.string(from: Date())
        cell.timeLabel.text = current_date_string
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyBoard = UIStoryboard(name: "Admin", bundle: nil)
        
        let chatVC = storyBoard.instantiateViewController(withIdentifier: "AdminMainChatViewController") as! AdminMainChatViewController
        let data = self.viewModel.emList[indexPath.row]
        chatVC.navTitle = data.USER_USERID
        chatVC.userId = data.USER_ID
        
        self.navigationController?.pushViewController(chatVC, animated: true)
    }
}
