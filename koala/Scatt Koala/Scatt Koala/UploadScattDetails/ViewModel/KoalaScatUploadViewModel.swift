//
//  KoalaScatUploadViewModel.swift
//  Scatt Koala
//
//

import Foundation

class KoalaScatUploadViewModel {
    func uploadKoalaDetails(koalaPresent: String, numberOfScatCollected: String, scatCondition: String, currentLocation: String, lat: String, long: String, treeSpecies: String, onCompletion: @escaping (KoalaScatResponseModel?, Bool) -> ()) {
        NetworkManager.performRequest(endpoint: .scatCreate, method: .POST, parameters: ["koalaPresent": koalaPresent, "currentLocation": currentLocation, "lat": lat, "long": long, "treeSpecies": treeSpecies, "numberOfScatCollected": numberOfScatCollected, "scatCondition": scatCondition])
        { (result: Result<KoalaScatResponseModel, NetworkManager.NetworkError>) in
            switch result {
            case .success(let response):
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
