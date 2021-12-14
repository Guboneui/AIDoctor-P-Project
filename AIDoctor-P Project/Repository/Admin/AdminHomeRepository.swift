//
//  AdminHomeRepository.swift
//  AIDoctor-P Project
//
//  Created by 구본의 on 2021/12/14.
//

import Foundation
import Alamofire

class AdminHomeRepository {
    func getEmList(onCompleted: @escaping (AmdinEmListResponse) -> Void, onError: @escaping (String) -> Void) {
        AF.request("\(ConstantURL.BASE_URL)/fcm/emList", method: .get, headers: nil)
            .validate()
            .responseDecodable(of: AmdinEmListResponse.self) { response in
                switch response.result {
                    case .success(let response):
                        AIDoctorLog.debug("AdminHomeRepository - getEmList")
                        onCompleted(response)
                    case .failure(let error):
                        AIDoctorLog.debug("AdminHomeRepository - getEmList Error: \(error)")
                }
            }
    }
    
}
