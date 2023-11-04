//
//  ForgotPasswordViewModel.swift
//  Scatt Koala
//
//

import Foundation

class ForgotPasswordViewModel {
    
    func forgotPassword(emailId: String, onSuccess: @escaping (ForgotPasswordModel?) -> (), onFailure: @escaping (String?) -> ()) {
        NetworkManager.performRequest(endpoint: .forgotPassword, method: .POST, parameters: ["email": emailId])
        { (result: Result<ForgotPasswordModel, NetworkManager.NetworkError>) in
            switch result {
            case .success(let response):
                onSuccess(response)
            case .failure(let error):
                if let serverErrorMessage = error.serverErrorMessage {
                    onFailure(serverErrorMessage)
                } else {
                    onFailure(error.localizedDescription)
                }
            }
        }
    }

}
