//
//  VerifyOtpViewModel.swift
//  Scatt Koala
//
//

import Foundation

class VerifyOtpViewModel {
    func verifyOtp(otp: String, Id: Double, onCompletion: @escaping (String?, String? , Bool?) -> () ) {
        NetworkManager.performRequest(endpoint: .verifyOtp, method: .POST, parameters: ["id": Id, "otp": otp])
        { (result: Result<VerifyOtpResponseModel, NetworkManager.NetworkError>) in
            switch result {
                
            case .success(let response):
                onCompletion(response.msg, response.status, true)
            case .failure(let error):
                onCompletion(error.serverErrorMessage, error.localizedDescription, false)
            }
        }
    }
}
