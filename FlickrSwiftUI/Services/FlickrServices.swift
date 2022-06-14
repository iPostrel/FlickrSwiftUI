//
//  FlickrServices.swift
//  FlickrSwiftUI
//
//  Created by Денис on 04.06.2022.
//

import Foundation
import SwiftUI
import Combine

@MainActor
class FlickrServices: ObservableObject {
    @Published var photos = [Photo]()
    @Published var photoInfo: PhotoInfo?
    @Published var isLoadingPage = false
    @Published var isLoadingImage = false
    @Published var data: Data?
    
    private var canLoadMorePages = true
    private var cancellables = Set<AnyCancellable>()
    
    
    func loadContent() {
        guard !isLoadingPage && canLoadMorePages else { return }
        isLoadingPage = true
        
        URLSession.shared.dataTaskPublisher(for: URLBuilder.createPopular())
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
                self.isLoadingPage = false
            },
                  receiveValue: { value in
                if let photos = value as? [Photo] {
                    self.photos = photos
                }
            })
            .store(in: &cancellables)
    }
    
    func loadImageInfo(photo: Photo) {
        guard !isLoadingImage else { return }
        isLoadingImage = true
        
        photoInfo = nil
        data = nil
        
        var newData: Data?
        
        URLSession.shared.dataTaskPublisher(for: URLBuilder.createImageInfo(photo: photo))
            .map({ a in
                newData = a.data
                return a.data
            })
            .decode(type: PhotoInfoModel.self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .handleEvents(receiveOutput: { response in
                self.isLoadingImage = false
            })
            .map({ response -> PhotoInfo? in
                self.photoInfo = response.photo
                return self.photoInfo
            })
            .catch({ _ in Just(self.photoInfo) })
            .sink(receiveCompletion: { _ in
                self.isLoadingImage = false
            },
                  receiveValue: { value in
                if let photo = value {
                    self.photoInfo = photo
                    self.data = newData
                }
            })
            .store(in: &cancellables)
    }
}
