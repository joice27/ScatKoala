//
//  ViewModel.swift
//  Scatt Koala
//
//  Created by Joice George on 05/10/23.
//

import Foundation
import UIKit

class SignInViewModel {
    
    func signIn(email: String, password: String, omCompletion: @escaping (String?, Bool) -> ()) {
        NetworkManager.performRequest(endpoint: .login, method: .POST, parameters: ["email": email, "password": password]) { (result: Result<SignInResponseModel, NetworkManager.NetworkError>) in
            switch result {
            case .success(let response):
                omCompletion(response.status, true)
            case .failure(let error):
                if let serverErrorMessage = error.serverErrorMessage {
                    omCompletion(serverErrorMessage, false)
                } else {
                    omCompletion(error.localizedDescription, false)
                }
            }
        }
    }
}
