//
//  KoalaScatResponseModel.swift
//  Scatt Koala
//
//  Created by Joice George on 05/10/23.
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
