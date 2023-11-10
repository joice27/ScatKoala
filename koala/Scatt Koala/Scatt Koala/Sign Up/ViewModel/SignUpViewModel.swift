//
//  SignUpViewModel.swift
//  Scatt Koala
//
//

import Foundation

class SignUpViewModel {
    func SignUp(email: String, password: String, firstName: String, lastName: String, onCompletion: @escaping (SignUpResponseModel?, Bool) -> ()) {
        NetworkManager.performRequest(endpoint: .userCreation, method: .POST, parameters: ["email": email, "password": password, "lastName": lastName, "firstName": firstName]) { (result: Result<SignUpResponseModel, NetworkManager.NetworkError>) in
            switch result {
            case .success(let response):
                UserDefaults.standard.setValue(response.dataResponse?.id, forKey: "userId")
                onCompletion(response, true)
//                if let id = response.dataResponse?.id {
//                    omCompletion(response.msg, id, true)
//                } else {
//                    omCompletion(response.msg, nil, true) // id is nil, pass nil
//                }
            case .failure(let error):
                if error.serverErrorMessage != nil {
                    onCompletion(nil, false)
                } else {
                    onCompletion(nil, false)
                }
            }
        }
    }

}
