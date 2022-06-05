//
//  FlickrServices.swift
//  FlickrSwiftUI
//
//  Created by Денис on 04.06.2022.
//

import Foundation
import Combine

@MainActor
class FlickrServices: ObservableObject {
    @Published var photos = [Photo]()
    @Published var isLoadingPage = false
    
    private var currentPage = 1
    private var canLoadMorePages = true
    private var cancellables = Set<AnyCancellable>()
    private let constants = Constants()
    
    init() {
        loadContent()
    }
    
    private func loadContent() {
        guard !isLoadingPage && canLoadMorePages else {
            return
        }
        
        isLoadingPage = true
        
        URLSession.shared.dataTaskPublisher(for: urlPopularBuilder())
            .map(\.data)
            .decode(type: PopularPhotosModel.self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .handleEvents(receiveOutput: { response in
                self.isLoadingPage = false
                self.canLoadMorePages = false
            })
            .map({ response in
                return self.photos + (response.photos?.photo ?? [Photo]())
            })
            .catch({ _ in Just(self.photos) })
            .sink(receiveCompletion: { _ in
                    print ("receiveCompletion: [\(self.photos.count)]")
                },
                  receiveValue: { value in
                    if let photos = value as? [Photo] {
                        self.photos = photos
                    }
                })
            .store(in: &cancellables)
    }
    
    
    func urlPopularBuilder() -> URL {
        var components = URLComponents()
        components.scheme = constants.scheme
        components.host = constants.host
        components.path = constants.path
        
        components.queryItems = [
            URLQueryItem(name: "method", value: constants.methodPopular),
            URLQueryItem(name: "api_key", value: constants.apiKey),
            URLQueryItem(name: "user_id", value: constants.userID),
            URLQueryItem(name: "format", value: "json"),
            URLQueryItem(name: "nojsoncallback", value: "1")
        ]
        return URL(string: components.string!)!
    }
    
    func urlImageBuilder(photo: Photo) -> URL {
        let pathImade = "/\(photo.server ?? "")/\(photo.id ?? "")_\(photo.secret ?? "")_\(constants.sizeSuffix).jpg"
        
        var components = URLComponents()
        components.scheme = constants.scheme
        components.host = constants.hostImage
        components.path = pathImade
        
        return URL(string: components.string!)!
    }
}
