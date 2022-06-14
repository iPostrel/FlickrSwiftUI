//
//  PhotoInfoModel.swift
//  FlickrSwiftUI
//
//  Created by Денис on 11.06.2022.
//

import Foundation

struct PhotoInfoModel: Codable {
    let photo: PhotoInfo?
    let stat: String?
}

struct PhotoInfo: Codable {
    let id, secret, server: String?
    let farm: Int?
    let dateuploaded: String?
    let isfavorite: Int?
    let license, safetyLevel: String?
    let rotation: Int?
    let owner: Owner?
    let title, description: Comments?
    let visibility: Visibility?
    let dates: Dates?
    let views: String?
    let editability, publiceditability: Editability?
    let usage: Usage?
    let comments: Comments?
    let tags: Tags?
    let media: String?
}

struct Owner: Codable {
    let nsid: String?
    let username, realname: String?
    let location, iconserver: String?
    let iconfarm: Int?
    let pathAlias: String?
}

struct Comments: Codable {
    let _content: String?
}

struct Visibility: Codable {
    let ispublic, isfriend, isfamily: Int?
}

struct Dates: Codable {
    let posted, taken: String?
    let takengranularity, takenunknown: Int?
    let lastupdate: String?
}

struct Editability: Codable {
    let cancomment, canaddmeta: Int?
}

struct Usage: Codable {
    let candownload, canblog, canprint, canshare: Int?
}

struct Tags: Codable {
    let tag: [Tag]?
}

struct Tag: Codable, Hashable {
    let id: String?
    let author: String?
    let authorname: String?
    let raw, content: String?
    let machineTag: Int?
}
