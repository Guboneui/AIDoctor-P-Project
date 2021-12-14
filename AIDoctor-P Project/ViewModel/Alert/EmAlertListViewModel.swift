//
//  EmAlertListViewModel.swift
//  AIDoctor-P Project
//
//  Created by 구본의 on 2021/12/14.
//

import Foundation

class EmAlertListViewModel {
    weak var alertListView: AlertListViewController?
    let userService = EmAlertListService()
    
    var alertList: [EmAlertList] = [] {
        didSet {
            alertListView?.alertListTableView.reloadData()
        }
    }
    
    
    func postEmAlertList(_ parameters: EmAlertListRequest) {
        userService.postEmAlertList(parameters, onCompleted: { [weak self] response in
            AIDoctorLog.debug("EmAlertListViewModel - postEmAlertList")
            guard let self = self else {return}
            let message = response.message
            let code = response.code
            
            if response.isSuccess == true {
                AIDoctorLog.debug("code: \(code), message: \(message)")
                self.alertList = response.results!.results
                
            } else {
                AIDoctorLog.debug("code: \(code), message: \(message)")
            }
        }, onError: {error in
            AIDoctorLog.debug("EmAlertListViewModel - postEmAlertList Error: \(error)")
            AIDoctorLog.debug("EmAlertListViewModel - postEmAlertList")
        })
    }
}
