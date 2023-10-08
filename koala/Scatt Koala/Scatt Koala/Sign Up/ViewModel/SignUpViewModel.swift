//
//  SignUpViewModel.swift
//  Scatt Koala
//
//  Created by Joice George on 05/10/23.
//

import Foundation

class SignUpViewModel {
    func SignUp(email: String, password: String, firstName: String, lastName: String, omCompletion: @escaping (String?, Bool) -> ()) {
        NetworkManager.performRequest(endpoint: .userCreation, method: .POST, parameters: ["email": email, "password": password, "lastName": lastName, "firstName": firstName]) { (result: Result<SignUpResponseModel, NetworkManager.NetworkError>) in
            switch result {
            case .success(let response):
                omCompletion(response.message?.message, true)
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
