//
//  KoalaResponseModel.swift
//  Scatt Koala
//
//  Created by Joice George on 05/10/23.
//

import Foundation

struct KoalaResponseModel: Codable {
    let status: String?
    let msg: Response
}

struct Response: Codable {
    let message: String?
    let id: Int?
}
