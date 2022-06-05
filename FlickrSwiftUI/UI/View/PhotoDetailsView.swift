//
//  PhotoDetailsView.swift
//  FlickrSwiftUI
//
//  Created by Денис on 01.06.2022.
//

import SwiftUI

struct PhotoDetailsView: View {
    var photo: Photo
    var url: URL
    
    private let textLogo = "Photo Details"
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
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
                
                VStack(alignment: .leading, spacing: 20) {
                    PhotoDetailsRowView(title: "id: ", volue: photo.id ?? "")
                    PhotoDetailsRowView(title: "owner: ", volue: photo.owner ?? "")
                    PhotoDetailsRowView(title: "secret: ", volue: photo.secret ?? "")
                    PhotoDetailsRowView(title: "server: ", volue: photo.server ?? "")
                    PhotoDetailsRowView(title: "farm: ", volue: "\(photo.farm ?? 0)")
                    PhotoDetailsRowView(title: "title: ", volue: photo.title ?? "")
                    PhotoDetailsRowView(title: "ispublic: ", volue: "\(photo.ispublic ?? 0)")
                    PhotoDetailsRowView(title: "isfriend: ", volue: "\(photo.isfriend ?? 0)")
                    PhotoDetailsRowView(title: "isfamily: ", volue: "\(photo.isfamily ?? 0)")
                }
                .multilineTextAlignment(.leading)
                .padding()
            }
            .padding(.vertical)
            .navigationTitle(textLogo)
        }
    }
}

private struct PhotoDetailsRowView: View {
    var title: String
    var volue: String
    
    var body: some View {
        HStack(alignment: .top) {
            Text(title)
                .font(.headline)
            Text(volue)
                .font(.body)
                .foregroundColor(.gray)
        }
    }
}
