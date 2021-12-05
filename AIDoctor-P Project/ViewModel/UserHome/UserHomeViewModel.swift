//
//  UserHomeViewModel.swift
//  AIDoctor-P Project
//
//  Created by 구본의 on 2021/12/06.
//

import Foundation

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
            AIDoctorLog.debug("UserHomeViewModel - getDiseaseInfo")
        })
    }
}
