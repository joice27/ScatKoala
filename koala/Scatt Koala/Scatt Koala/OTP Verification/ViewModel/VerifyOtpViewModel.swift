//
//  VerifyOtpViewModel.swift
//  Scatt Koala
//
//  Created by Joice George on 10/10/23.
//

import Foundation

class VerifyOtpViewModel {
    func verifyOtp(otp: String, Id: Double, onCompletion: @escaping (String?, String? , Bool?) -> () ) {
        NetworkManager.performRequest(endpoint: .verifyOtp, method: .POST, parameters: ["id": Id, "otp": otp])
        { (result: Result<VerifyOtpResponseModel, NetworkManager.NetworkError>) in
            switch result {
                
            case .success(let response):
                print("joice success", response.msg)
                onCompletion(response.msg, response.status, true)
            case .failure(let error):
                onCompletion(error.serverErrorMessage, error.localizedDescription, false)
                print("joice failiure", error.localizedDescription)
            }
        }
    }
}
