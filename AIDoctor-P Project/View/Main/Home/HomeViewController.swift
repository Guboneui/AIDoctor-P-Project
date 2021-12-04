//
//  HomeViewController.swift
//  AIDoctor-P Project
//
//  Created by 구본의 on 2021/12/01.
//

import UIKit

class HomeViewController: UIViewController {
    
    @IBOutlet weak var homeTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setNavigationBar()
        setTableView()
        
     
        
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
        
        homeTableView.register(UINib(nibName: "CovidTableViewCell", bundle: nil), forCellReuseIdentifier: "CovidTableViewCell")
        homeTableView.register(UINib(nibName: "DiseaseTableViewCell", bundle: nil), forCellReuseIdentifier: "DiseaseTableViewCell")
        homeTableView.register(UINib(nibName: "HospitalTableViewCell", bundle: nil), forCellReuseIdentifier: "HospitalTableViewCell")
        homeTableView.register(UINib(nibName: "WhiteLabelTableViewCell", bundle: nil), forCellReuseIdentifier: "WhiteLabelTableViewCell")
        
    }
}

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "CovidTableViewCell", for: indexPath) as! CovidTableViewCell
            cell.selectionStyle = .none
            return cell
        } else if indexPath.row == 1{
            let cell = tableView.dequeueReusableCell(withIdentifier: "DiseaseTableViewCell", for: indexPath) as! DiseaseTableViewCell
            cell.selectionStyle = .none
            cell.delegate = self
            return cell
        } else if indexPath.row == 2{
            let cell = tableView.dequeueReusableCell(withIdentifier: "HospitalTableViewCell", for: indexPath) as! HospitalTableViewCell
            cell.selectionStyle = .none
            cell.delegate = self
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "WhiteLabelTableViewCell", for: indexPath) as! WhiteLabelTableViewCell
            cell.selectionStyle = .none
            return cell
        }
        
    }
}

extension HomeViewController: DetailViewSecondDelegate {
    func goDiseaseView() {
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        let diseaseDetailView = storyBoard.instantiateViewController(withIdentifier: "DiseaseViewController")
        
        self.navigationController?.pushViewController(diseaseDetailView, animated: true)
    }
    
    
}

extension HomeViewController: HospitalDetailViewFirstDelegate {
    func goHospital() {
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        let hospitalView = storyBoard.instantiateViewController(withIdentifier: "HospitalViewController")
        self.navigationController?.pushViewController(hospitalView, animated: true)
    }
    
    
}


