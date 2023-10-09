//
//  ViewModel.swift
//  Scatt Koala
//
//  Created by Joice George on 05/10/23.
//

import Foundation
import UIKit

class SignInViewModel {
    
    func signIn(email: String, password: String, omCompletion: @escaping (SignInResponseModel?, Bool) -> ()) {
        NetworkManager.performRequest(endpoint: .login, method: .POST, parameters: ["email": email, "password": password]) { (result: Result<SignInResponseModel, NetworkManager.NetworkError>) in
            switch result {
            case .success(let response):
                omCompletion(response, true)
            case .failure(let error):
                if let serverErrorMessage = error.serverErrorMessage {
                    omCompletion(nil, false)
                } else {
                    omCompletion(nil, false)
                }
            }
        }
    }
}
