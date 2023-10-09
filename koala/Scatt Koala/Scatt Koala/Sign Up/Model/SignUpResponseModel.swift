//
//  Model.swift
//  Scatt Koala
//
//  Created by Joice George on 05/10/23.
//

import Foundation

struct SignUpResponseModel: Codable {
    let status: String?
    let msg: String?
    let dataResponse: DataResponse?
    
    struct DataResponse: Codable {
        let id: Int?
    }
}

