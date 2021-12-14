//
//  AdminHomeViewModel.swift
//  AIDoctor-P Project
//
//  Created by 구본의 on 2021/12/14.
//

import Foundation

class AdminHomeViewModel {
    
    weak var adminMain: AdminViewController?
    
    let service: AdminHomeService = AdminHomeService()
    
    var emList: [AmdinEmList] = [] {
        didSet {
            self.adminMain?.mainTableView.reloadData()
        }
    }
    
    func getEmList() {
        service.getEmList(onCompleted: { [weak self] response in
            guard let self = self else {return}
            if response.isSuccess == true {
                AIDoctorLog.debug("AdminHomeViewModel - getEmList")
                let code = response.code
                let message = response.message
                AIDoctorLog.debug("Code: \(code), Message: \(message)")
                self.emList = response.results!.results
            } else {
                AIDoctorLog.debug("AdminHomeViewModel - getEmList Error")
            }
        }, onError: { error in
            AIDoctorLog.debug("AdminHomeViewModel - getEmList Error: \(error)")
            
        })
    }
}
