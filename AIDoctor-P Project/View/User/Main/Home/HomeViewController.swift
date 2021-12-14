//
//  HomeViewController.swift
//  AIDoctor-P Project
//
//  Created by 구본의 on 2021/12/01.
//

import UIKit
import CoreLocation


class HomeViewController: UIViewController, CLLocationManagerDelegate {
    
    @IBOutlet weak var homeTableView: UITableView!
    
    lazy var viewModel: UserHomeViewModel = UserHomeViewModel()
    var locationManager = CLLocationManager()
    
    var xPos: Double?
    var yPos: Double?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setNavigationBar()
        setTableView()
        self.viewModel.homeView = self
        self.viewModel.getDiseaseInfo()
        self.viewModel.getCovidInfo()
        
        
        if CLLocationManager.locationServicesEnabled() {
            AIDoctorLog.debug("현재 사용자의 위치정보를 불러왔습니다.")
            locationManager.startUpdatingLocation() //위치 정보 받아오기 시작
            self.yPos = locationManager.location?.coordinate.latitude
            self.xPos = locationManager.location?.coordinate.longitude
            let param = HospitalRequest(xPos: Float(self.xPos ?? 127.1270), yPos: Float(self.yPos ?? 37.4476), sbjCode: 1)
            AIDoctorLog.debug("xPos: \(String(describing: self.xPos)), yPos: \(String(describing: self.yPos))")
            self.viewModel.postHospitalInfo(param)
        } else {
            AIDoctorLog.debug("현재 사용자의 위치정보 서비스가 거부되어있습니다.")
        }
        
        
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
    
    
    @IBAction func alertListButtonAction(_ sender: Any) {
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        let alertListView = storyBoard.instantiateViewController(withIdentifier: "AlertListViewController") as! AlertListViewController
        self.navigationController?.pushViewController(alertListView, animated: true)
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
            cell.refreshCovid.addTarget(self, action: #selector(reloadCovid), for: .touchUpInside)
            cell.covidNumLabel.text = "\(self.viewModel.covidInfo ?? 0)명"
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
            
            let reloadHospitalInfoTap = UITapGestureRecognizer(target: self, action: #selector(reloadHospital))
            cell.refreshLocationStackView.addGestureRecognizer(reloadHospitalInfoTap)
            return cell
        }
    }
    
    @objc func reloadCovid(_ sender: UIButton) {
        self.viewModel.getCovidInfo()
    }
    
    @objc func reloadHospital(_ sender: UITapGestureRecognizer) {
        if CLLocationManager.locationServicesEnabled() {
            
            let alert = UIAlertController(title: "위치 정보", message: "현재 위치로 부터 가까운 병원을 조회합니다.", preferredStyle: .alert)
            let okButton = UIAlertAction(title: "확인", style: .default, handler: nil)
            alert.addAction(okButton)
            self.present(alert, animated: true)
            
            AIDoctorLog.debug("현재 사용자의 위치정보를 불러왔습니다.")
            locationManager.startUpdatingLocation() //위치 정보 받아오기 시작
            self.yPos = locationManager.location?.coordinate.latitude
            self.xPos = locationManager.location?.coordinate.longitude
            let param = HospitalRequest(xPos: Float(self.xPos ?? 127.1270), yPos: Float(self.yPos ?? 37.4476), sbjCode: 1)
            AIDoctorLog.debug("xPos: \(String(describing: self.xPos)), yPos: \(String(describing: self.yPos))")
            self.viewModel.postHospitalInfo(param)
        } else {
            AIDoctorLog.debug("현재 사용자의 위치정보 서비스가 거부되어있습니다.")
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


