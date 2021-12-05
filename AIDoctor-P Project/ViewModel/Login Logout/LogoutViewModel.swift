//
//  LogoutViewModel.swift
//  AIDoctor-P Project
//
//  Created by 구본의 on 2021/12/06.
//

import Foundation

protocol LogoutViewModelDelegate: AnyObject {
    func goLoginView()
}

class LogoutViewModel {
    weak var settingView: SettingViewController?
    let logoutService = LogoutService()
    weak var delegate: LogoutViewModelDelegate?
    func getLogout() {
        logoutService.getLogout(onCompleted: { [weak self] response in
            guard let self = self else {return}
            let message = response.message
            let code = response.code
            
            if response.isSuccess == true {
                AIDoctorLog.debug("code: \(code), message: \(message)")
                self.delegate?.goLoginView()
            } else {
                AIDoctorLog.debug("code: \(code), message: \(message)")
            }
        }, onError: {error in
            AIDoctorLog.debug("LogoutViewModel - getLogout Error: \(error)")
        })
    }
}
