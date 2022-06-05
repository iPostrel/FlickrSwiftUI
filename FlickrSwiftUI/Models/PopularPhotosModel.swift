//
//  PhotoInfo.swift
//  FlickrSwiftUI
//
//  Created by Денис on 01.06.2022.
//

import Foundation

struct PopularPhotosModel: Decodable {
    let photos: Photos?
    let stat: String?
}

struct Photos: Decodable {
    let page: Int?
    let pages: Int?
    let perpage: Int?
    let total: Int?
    let photo: [Photo?]
}

struct Photo: Equatable, Decodable, Hashable {
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
