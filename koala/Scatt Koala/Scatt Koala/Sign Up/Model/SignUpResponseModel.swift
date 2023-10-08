//
//  Model.swift
//  Scatt Koala
//
//  Created by Joice George on 05/10/23.
//

import Foundation

struct SignUpResponseModel: Codable {
    let status: String?
    let message: MessageResponse?
}

struct MessageResponse: Codable {
    let message: String?
    let id: Int?
}
