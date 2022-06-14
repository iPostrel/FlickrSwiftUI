//
//  Constants.swift
//  FlickrSwiftUI
//
//  Created by Денис on 04.06.2022.
//

import Foundation

struct Constants { }

extension Constants {
    struct Url {
        static let scheme = "https"
        static let host = "www.flickr.com"
        static let hostImage = "live.staticflickr.com"
        static let path = "/services/rest/"
    }
}

extension Constants {
    struct Key {
        static let apiKey = "016c809e661bfd34ba762b7e290d414b"
        static let userID = "66956608@N06"
        static let sizeSuffix = "w"
    }
}

extension Constants {
    struct Mmethod {
        static let popular = "flickr.photos.getPopular"
        static let info = "flickr.photos.getInfo"
    }
}

extension Constants {
    struct Keychain {
        static let account: String = "FlickrSwiftUI"
        static let oAuthToken: String = "oauth_token"
    }
}
