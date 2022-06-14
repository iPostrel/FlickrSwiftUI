//
//  PhotosListView.swift
//  FlickrSwiftUI
//
//  Created by Денис on 04.06.2022.
//

import SwiftUI

struct PhotosListView: View {
    @EnvironmentObject private var dataSource: FlickrServices
    
    private let textProgress = "Fetching data, please wait..."
    private let textNoPhoto = "There are no photos yet"
    
    var body: some View {
        ScrollView {
            LazyVStack {
                ForEach(Array(dataSource.photos), id:\.self) { photo in
                    NavigationLink(destination: PhotoDetailsView(photo: photo, url: URLBuilder.createImage(photo: photo))) {
                        PhotoRowView(url: URLBuilder.createImage(photo: photo))
                    }
                }
            }
        }
        .padding(.horizontal)
        .listStyle(.automatic)
        .onAppear() {
            dataSource.loadContent()
        }
        .safeAreaInset(edge: .bottom) {
            VStack {
                if !dataSource.photos.isEmpty {
                    Divider()
                    Text("Total: \(dataSource.photos.count)")
                        .foregroundStyle(.secondary)
                        .padding(.bottom)
                }
            }
            .background(.bar)
        }
        .overlay() {
            if dataSource.isLoadingPage && dataSource.photos.isEmpty {
                ProgressView(textProgress)
                    .progressViewStyle(CircularProgressViewStyle(tint: .accentColor))
            } else if dataSource.photos.isEmpty {
                Text(textNoPhoto)
                    .foregroundStyle(.secondary)
                    .padding(.bottom)
            }
        }
        .animation(.default, value: dataSource.photos)
        
    }
}

struct PhotosListView_Previews: PreviewProvider {
    static var previews: some View {
        PhotosListView()
    }
}

private struct PhotoRowView: View {
    var url: URL
    
    var body: some View {
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
            .cornerRadius(10)
    }
}
