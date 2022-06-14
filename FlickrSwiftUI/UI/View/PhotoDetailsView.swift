//
//  PhotoDetailsView.swift
//  FlickrSwiftUI
//
//  Created by Денис on 01.06.2022.
//

import SwiftUI

struct PhotoDetailsView: View {
    @EnvironmentObject private var dataSource: FlickrServices
    
    @FetchRequest(sortDescriptors: []) var listPhotos: FetchedResults<PhotoInfoEntity>
    @Environment(\.managedObjectContext) var moc
    
    var photo: Photo
    var url: URL
    
    private let textLogo = "Photo Details"
    private let textProgress = "Fetching data, please wait..."
    private let textNoPhoto = "There are no photo info yet"
    
    var body: some View {
        ScrollView {
            LazyVStack(alignment: .leading) {
                Rectangle()
                    .accentColor(Color(hue: 1.0, saturation: 0.007, brightness: 0.95))
                    .overlay(
                        AsyncImage(url: url) { image in
                            image
                                .resizable()
                                .scaledToFill()
                        } placeholder: {
                            ProgressView()
                        }
                    )
                    .aspectRatio(1, contentMode: .fit)
                
                if dataSource.isLoadingImage && dataSource.photoInfo == nil {
                    HStack(alignment: .bottom) {
                        Spacer()
                        ProgressView(textProgress)
                            .progressViewStyle(CircularProgressViewStyle(tint: .accentColor))
                        Spacer()
                    }
                } else if dataSource.photoInfo == nil {
                    HStack {
                        Spacer()
                        Text(textNoPhoto)
                            .foregroundStyle(.secondary)
                            .padding(.bottom)
                        Spacer()
                    }
                } else {
                    VStack(alignment: .leading, spacing: 20) {
                        PhotoDetailsRowView(title: "id: ", volue: dataSource.photoInfo?.id ?? "")
                        PhotoDetailsRowView(title: "owner: ", volue: dataSource.photoInfo?.owner?.username ?? "")
                        PhotoDetailsRowView(title: "secret: ", volue: dataSource.photoInfo?.secret ?? "")
                        PhotoDetailsRowView(title: "server: ", volue: dataSource.photoInfo?.server ?? "")
                        PhotoDetailsRowView(title: "farm: ", volue: "\(dataSource.photoInfo?.farm ?? 0)")
                        PhotoDetailsRowView(title: "title: ", volue: dataSource.photoInfo?.title?._content ?? "1")
                        PhotoDetailsRowView(title: "description: ", volue: dataSource.photoInfo?.description?._content ?? "")
                    }
                    .padding()
                    .onAppear() {
                        savePhotoInfoData()
                    }
                    
                    PhotoDetailsTagsView(tags: dataSource.photoInfo?.tags?.tag ?? [Tag]())
                }

            }
            .padding(.vertical)
            .navigationTitle(textLogo)
        }
        .listStyle(.automatic)
        .onAppear() {
            getPhotoInfoData()
        }
    }
    
    private func getPhotoInfoData() {
        var data: Data?
        var isEntity = false
        for info in listPhotos {
            if let infoUrl = info.url, infoUrl == url {
                data = info.data
                isEntity = true
                break
            }
        }
        
        if isEntity, let data = data {
            // Data from CoreData
            do {
                let dataObj = try JSONDecoder().decode(PhotoInfoModel.self, from: data)
                dataSource.photoInfo = dataObj.photo
            } catch {
                print(error)
            }
        } else {
            // load Image Info
            dataSource.loadImageInfo(photo: photo)
        }
    }
    
    private func savePhotoInfoData() {
        var isEntity = false
        for info in listPhotos {
            if let infoUrl = info.url, infoUrl == url {
                isEntity = true
                break
            }
        }
        if !isEntity {
            // Save Photo Info
            let info = PhotoInfoEntity(context: self.moc)
            info.url = url
            info.data = dataSource.data
            try? self.moc.save()
        }
    }
}

private struct PhotoDetailsRowView: View {
    var title: String
    var volue: String
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(title)
                .font(.headline)
            Text(volue)
                .font(.body)
                .foregroundColor(.gray)
        }
    }
}

private struct PhotoDetailsTagsView: View {
    var tags: [Tag]
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("Tag: ")
                .font(.headline)
            ForEach(Array(tags), id:\.self) { tag in
                Text(tag.raw ?? "")
                    .font(.body)
                    .foregroundColor(.gray)
            }
        }
        .padding()
    }
}
