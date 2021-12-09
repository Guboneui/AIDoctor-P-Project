//
//  UserHomeViewModel.swift
//  AIDoctor-P Project
//
//  Created by 구본의 on 2021/12/06.
//

import Foundation
import Alamofire

protocol UserHomeViewModelDelegate: AnyObject {
}

class UserHomeViewModel {
    weak var homeView: HomeViewController?
    let userHomeService = UserHomeService()
    
    var diseaseInfo: [DiseaseInfo] = [] {
        didSet {
            self.homeView?.homeTableView.reloadData()
            AIDoctorLog.debug("HomeViewController - homeTableView - Reload")
        }
    }
    
    var hospitalInfo: [HospitalInfo] = [] {
        didSet {
            self.homeView?.homeTableView.reloadData()
            AIDoctorLog.debug("HomeViewController - homeTableView - Reload")
        }
    }
    
    var covidInfo: Int? {
        didSet {
            self.homeView?.homeTableView.reloadData()
            AIDoctorLog.debug("HomeViewController - homeTableView - reload")
        }
    }
    
    func getDiseaseInfo() {
        userHomeService.getDiseaseInfo(onCompleted: { [weak self] response in
            AIDoctorLog.debug("UserHomeViewModel - getDiseaseInfo")
            guard let self = self else {return}
            let message = response.message
            let code = response.code
            
            if response.isSuccess == true {
                AIDoctorLog.debug("code: \(code), message: \(message)")
                self.diseaseInfo = response.results!
            } else {
                AIDoctorLog.debug("code: \(code), message: \(message)")
            }
        }, onError: {error in
            AIDoctorLog.debug("UserHomeViewModel - getDiseaseInfo Error: \(error)")
            
        })
    }
    
    func postHospitalInfo(_ parameters: HospitalRequest) {
        userHomeService.postHospitalInfo(parameters) { [weak self] response in
            AIDoctorLog.debug("UserHomeViewModel - postHospitalInfo")
            guard let self = self else {return}
            let message = response.message
            let code = response.code
            
            if response.isSuccess == true {
                AIDoctorLog.debug("code: \(code), message: \(message)")
                self.hospitalInfo = response.results!
            } else {
                AIDoctorLog.debug("code: \(code), message: \(message)")
            }
        } onError: { error in
            AIDoctorLog.debug("UserHomeViewModel - postHospitalInfo Error: \(error)")
        }
    }
    
    func getCovidInfo() {
        userHomeService.getCovidInfo(onCompleted: { [weak self] response in
            AIDoctorLog.debug("UserHomeViewModel - getCovidInfo")
            guard let self = self else {return}
            let message = response.message
            let code = response.code
            
            if response.isSuccess == true {
                AIDoctorLog.debug("code: \(code), message: \(message)")
                self.covidInfo = response.results
            } else {
                AIDoctorLog.debug("code: \(code), message: \(message)")
            }
        }, onError: {error in
            AIDoctorLog.debug("UserHomeViewModel - getCovidInfo Error: \(error)")
            
        })
    }
   
    
}
