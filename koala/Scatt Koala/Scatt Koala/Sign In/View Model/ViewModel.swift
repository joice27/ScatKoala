//
//  ViewModel.swift
//  Scatt Koala
//
//

import Foundation
import UIKit

class SignInViewModel {
    
    func signIn(email: String, password: String, omCompletion: @escaping (SignInResponseModel?, Bool) -> ()) {
        NetworkManager.performRequest(endpoint: .login, method: .POST, parameters: ["email": email, "password": password]) { (result: Result<SignInResponseModel, NetworkManager.NetworkError>) in
            switch result {
            case .success(let response):
                UserDefaults.standard.setValue(response.dataResponse?.id, forKey: "userId")
                omCompletion(response, true)
            case .failure(let error):
                if error.serverErrorMessage != nil {
                    omCompletion(nil, false)
                } else {
                    omCompletion(nil, false)
                }
            }
        }
    }
}
