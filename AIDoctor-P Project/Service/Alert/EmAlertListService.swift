//
//  EmAlertListService.swift
//  AIDoctor-P Project
//
//  Created by 구본의 on 2021/12/14.
//

import Foundation

class EmAlertListService {
    let repository: EmAlertListRepository = EmAlertListRepository()
    
    func postEmAlertList(_ parameters: EmAlertListRequest, onCompleted: @escaping (EmAlertListResponse) -> Void, onError: @escaping (String) -> Void) {
        repository.postEmAlertList(parameters, onCompleted: { response in
            let responseData = EmAlertListResponse(isSuccess: response.isSuccess, code: response.code, message: response.message, results: response.results)
            onCompleted(responseData)
            AIDoctorLog.debug("EmAlertListService - postEmAlertList")
        }, onError: { error in
            onError("EmAlertListService - postEmAlertList Error: \(error)")
            AIDoctorLog.debug("EmAlertListService - postEmAlertList")
        })
    }
}
