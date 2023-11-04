//
//  Model.swift
//  Scatt Koala
//
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

