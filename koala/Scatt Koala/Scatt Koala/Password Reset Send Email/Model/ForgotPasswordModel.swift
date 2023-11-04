//
//  ForgotPasswordModel.swift
//  Scatt Koala
//
//

import Foundation

struct ForgotPasswordModel: Codable {
    let status: String
    let msg: String
    let dataResponse: UserID
}

struct UserID: Codable {
    let id: Int
}
