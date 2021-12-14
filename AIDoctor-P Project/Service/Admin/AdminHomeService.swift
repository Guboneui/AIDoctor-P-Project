//
//  AdminHomeService.swift
//  AIDoctor-P Project
//
//  Created by 구본의 on 2021/12/14.
//

import Foundation

class AdminHomeService {
    let repository: AdminHomeRepository = AdminHomeRepository()
    
    func getEmList(onCompleted: @escaping (AmdinEmListResponse) -> Void, onError: @escaping (String) -> Void) {
        repository.getEmList(onCompleted: { response in
            let responseData = AmdinEmListResponse(isSuccess: response.isSuccess, code: response.code, message: response.message, results: response.results)
            onCompleted(responseData)
            AIDoctorLog.debug("AdminHomeService - getEmList")
        }, onError: { error in
            onError("AdminHomeService - getEmList Error: \(error)")
            AIDoctorLog.debug("AdminHomeService - getEmList Error")
        })
    }
}
