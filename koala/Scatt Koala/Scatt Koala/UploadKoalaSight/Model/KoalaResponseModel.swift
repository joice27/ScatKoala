//
//  KoalaResponseModel.swift
//  Scatt Koala
//
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
