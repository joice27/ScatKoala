//
//  KoalaScatUploadViewModel.swift
//  Scatt Koala
//
//  Created by Joice George on 05/10/23.
//

import Foundation

class KoalaScatUploadViewModel {
    func uploadKoalaDetails(koalaPresent: String, numberOfScatCollected: String, scatCondition: String, currentLocation: String, lat: String, long: String, treeSpecies: String, onCompletion: @escaping (String?, Bool) -> ()) {
        NetworkManager.performRequest(endpoint: .scatCreate, method: "POST", parameters: ["koalaPresent": koalaPresent, "currentLocation": currentLocation, "lat": lat, "long": long, "treeSpecies": treeSpecies, "numberOfScatCollected": numberOfScatCollected, "scatCondition": scatCondition])
        { (result: Result<KoalaResponseModel, NetworkManager.NetworkError>) in
            switch result {
            case .success(let response):
                onCompletion(String(response.msg.id ?? 0), true)
            case .failure(let error):
                if let serverErrorMessage = error.serverErrorMessage {
                    onCompletion(serverErrorMessage, false)
                } else {
                    onCompletion(error.localizedDescription, false)
                }
            }
        }
    }

}
