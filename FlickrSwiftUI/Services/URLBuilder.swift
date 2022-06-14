//
//  URLBuilder.swift
//  FlickrSwiftUI
//
//  Created by Денис on 12.06.2022.
//

import Foundation

struct URLBuilder {
    
    static func createPopular() -> URL {
        var components = URLComponents()
        components.scheme = Constants.Url.scheme
        components.host = Constants.Url.host
        components.path = Constants.Url.path

        let urlParameters: [String: String] = [
            "method": Constants.Mmethod.popular,
            "api_key": Constants.Key.apiKey,
            "user_id": Constants.Key.userID,
            "format": "json",
            "nojsoncallback": "1"
        ]
        components.queryItems = withComponents(urlParameters)
        
        return URL(string: components.string!)!
    }
    
    static func createImage(photo: Photo) -> URL {
        let pathImade = "/\(photo.server ?? "")/\(photo.id ?? "")_\(photo.secret ?? "")_\(Constants.Key.sizeSuffix).jpg"
        
        var components = URLComponents()
        components.scheme = Constants.Url.scheme
        components.host = Constants.Url.hostImage
        components.path = pathImade
        
        return URL(string: components.string!)!
    }
    
    static func createImageInfo(photo: Photo) -> URL {
        var components = URLComponents()
        components.scheme = Constants.Url.scheme
        components.host = Constants.Url.host
        components.path = Constants.Url.path
        
        let urlParameters: [String: String] = [
            "method": Constants.Mmethod.info,
            "api_key": Constants.Key.apiKey,
            "photo_id": "\(photo.id ?? "")",
            "secret": "\(photo.secret ?? "")",
            "format": "json",
            "nojsoncallback": "1"
        ]
        components.queryItems = withComponents(urlParameters)
        
        return URL(string: components.string!)!
    }
}

extension URLBuilder {
    static func withComponents(_ queries: [String: String]) -> [URLQueryItem] {
        queries.map { URLQueryItem(name: $0.0, value: $0.1) }
    }
}
