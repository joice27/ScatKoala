//
//  KoalaScatResponseModel.swift
//  Scatt Koala
//
//

import Foundation

struct KoalaScatResponseModel: Codable {
    let status: String?
    let msg: String?
    let dataResponse: UploadId?
}

struct UploadId: Codable {
    let id: String?
}
