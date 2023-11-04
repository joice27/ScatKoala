//
//  SignInResponseModel.swift
//  Scatt Koala
//
//

import Foundation

struct SignInResponseModel: Codable {
    let status: String?
    let msg: String?
    let dataResponse: UserData?
}

struct UserData: Codable {
    let firstName: String?
    let lastName: String?
    let password: String?
    let id: Int?
    let email: String?
}

