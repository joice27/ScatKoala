//
//  NewPasswordViewModel.swift
//  Scatt Koala
//
//

import Foundation

class NewPasswordViewModel {
    func resetPassword(id: Double, newPassword: String, onSuccess: @escaping (ResetPasswordModel?) -> (), onFailure: @escaping (String?) -> ()) {
        NetworkManager.performRequest(endpoint: .resetPassword, method: .PUT, parameters: ["id": id, "newPassword": newPassword])
        { (result: Result<ResetPasswordModel, NetworkManager.NetworkError>) in
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
