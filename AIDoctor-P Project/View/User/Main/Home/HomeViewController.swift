//
//  HomeViewController.swift
//  AIDoctor-P Project
//
//  Created by 구본의 on 2021/12/01.
//

import UIKit


class HomeViewController: UIViewController {
    
    @IBOutlet weak var homeTableView: UITableView!
    
    lazy var viewModel: UserHomeViewModel = UserHomeViewModel()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setNavigationBar()
        setTableView()
        self.viewModel.homeView = self
        self.viewModel.getDiseaseInfo()
        
        let param = HospitalRequest(xPos: 127.1297, yPos: 37.4504, sbjCode: 5)
        self.viewModel.postHospitalInfo(param)
    }
    
    func setNavigationBar() {
        let backButton = UIBarButtonItem()
        backButton.title = ""
        self.navigationController?.navigationBar.topItem?.backBarButtonItem = backButton
    }
    
    func setTableView() {
        homeTableView.delegate = self
        homeTableView.dataSource = self
        homeTableView.separatorStyle = .none
        homeTableView.estimatedRowHeight = 50
        homeTableView.rowHeight = UITableView.automaticDimension
        let footerView = UIView(frame: CGRect(x: 0, y: 0, width: self.homeTableView.frame.width, height: 40))
        footerView.backgroundColor = .white
        self.homeTableView.tableFooterView = footerView
        
        homeTableView.register(UINib(nibName: "CovidTableViewCell", bundle: nil), forCellReuseIdentifier: "CovidTableViewCell")
        homeTableView.register(UINib(nibName: "DiseaseTableViewCell", bundle: nil), forCellReuseIdentifier: "DiseaseTableViewCell")
        homeTableView.register(UINib(nibName: "HospitalTableViewCell", bundle: nil), forCellReuseIdentifier: "HospitalTableViewCell")
    }
}

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "CovidTableViewCell", for: indexPath) as! CovidTableViewCell
            cell.selectionStyle = .none
            return cell
        } else if indexPath.row == 1{
            let cell = tableView.dequeueReusableCell(withIdentifier: "DiseaseTableViewCell", for: indexPath) as! DiseaseTableViewCell
            cell.selectionStyle = .none
            cell.diseaseInfo = self.viewModel.diseaseInfo
            cell.delegate = self
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "HospitalTableViewCell", for: indexPath) as! HospitalTableViewCell
            cell.selectionStyle = .none
            cell.hospitalInfo = self.viewModel.hospitalInfo
            cell.delegate = self
            return cell
        }
    }
}

extension HomeViewController: DiseaseInfoDelegate {
    func diseaseInfo(diseaseInfo: DiseaseInfo) {
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        let diseaseDetailView = storyBoard.instantiateViewController(withIdentifier: "DiseaseViewController") as! DiseaseViewController
        diseaseDetailView.diseaseInfo = diseaseInfo
        self.navigationController?.pushViewController(diseaseDetailView, animated: true)
    }
}

extension HomeViewController: HospitalInfoDelegate {
    func hospitalInfo(hospitalInfo: HospitalInfo) {
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        let hospitalView = storyBoard.instantiateViewController(withIdentifier: "HospitalViewController") as! HospitalViewController
        hospitalView.hospitalInfo = hospitalInfo
        self.navigationController?.pushViewController(hospitalView, animated: true)
    }
    
   
}


