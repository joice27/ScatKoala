//
//  SignInResponseModel.swift
//  Scatt Koala
//
//  Created by Joice George on 05/10/23.
//

import Foundation

struct SignInResponseModel: Codable {
    let status: String?
    let data: UserData?
}

struct UserData: Codable {
    let firstName: String?
    let lastName: String?
    let password: String?
    let id: Int?
    let email: String?
}

