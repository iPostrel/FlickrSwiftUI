//
//  PhotoInfo.swift
//  FlickrSwiftUI
//
//  Created by Денис on 01.06.2022.
//

import Foundation

struct PopularPhotosModel: Codable {
    let photos: Photos?
    let stat: String?
}

struct Photos: Codable {
    let page: Int?
    let pages: Int?
    let perpage: Int?
    let total: Int?
    let photo: [Photo?]
}

struct Photo: Equatable, Codable, Hashable {
    let id: String?
    let owner: String?
    let secret: String?
    let server: String?
    let farm: Int?
    let title: String?
    let ispublic: Int?
    let isfriend: Int?
    let isfamily: Int?
}
