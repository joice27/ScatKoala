//
//  HomeViewModel.swift
//  Scatt Koala
//
//  Created by Joice George on 06/11/23.
//

import Foundation

class HomeViewModel {
    func deleteAccount(onCompletion: @escaping (Bool) -> ()) {
        if let userId = UserDefaults.standard.value(forKey: "userId") as? Int {
            let parameter: [String: Any] = ["id" : userId]
            NetworkManager.performRequest(endpoint: .deletAccount, method: .DELETE, parameters: parameter) { (result: Result<SignUpResponseModel, NetworkManager.NetworkError>) in
                switch result {
                case .success(_):
                    onCompletion(true)
                case .failure(_):
                    onCompletion(false)
                }
            }
        }
    }
}
