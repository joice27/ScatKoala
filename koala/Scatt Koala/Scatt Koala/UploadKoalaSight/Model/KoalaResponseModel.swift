//
//  KoalaResponseModel.swift
//  Scatt Koala
//
//  Created by Joice George on 05/10/23.
//

import Foundation

struct KoalaResponseModel: Codable {
    let status: String?
    let msg: String?
    let dataResponse: Response?
}

struct Response: Codable {
    let id: String?
}

struct ImageResponse: Codable {
    let message: String?
    let dataResponse: String?
    let error: ErrorResponse?
}

struct ErrorResponse: Codable {
    
}
