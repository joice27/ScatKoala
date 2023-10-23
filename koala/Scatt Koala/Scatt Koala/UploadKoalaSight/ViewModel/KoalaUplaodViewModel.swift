//
//  KoalaUplaodViewModel.swift
//  Scatt Koala
//
//  Created by Joice George on 05/10/23.
//

import Foundation

class KoalaUplaodViewModel {
    func uploadKoalaDetails(koalaStatus: String, currentLocation: String, lat: String, long: String, treeSpecies: String, imageUrl: String, onCompletion: @escaping (KoalaResponseModel?, Bool) -> ()) {
        NetworkManager.performRequest(endpoint: .create, method: .POST, parameters: ["koalaStatus": koalaStatus, "currentLocation": currentLocation, "lat": lat, "long": long, "treeSpecies": treeSpecies, "imageUrl": imageUrl])
        { (result: Result<KoalaResponseModel, NetworkManager.NetworkError>) in
            switch result {
            case .success(let response):
                print("Koala resp", response)
                onCompletion(response, true)
            case .failure(let error):
                if let serverErrorMessage = error.serverErrorMessage {
                    onCompletion(nil, false)
                } else {
                    onCompletion(nil, false)
                }
            }
        }
    }

}
