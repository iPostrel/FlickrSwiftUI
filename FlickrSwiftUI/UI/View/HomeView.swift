//
//  HomeView.swift
//  FlickrSwiftUI
//
//  Created by Денис on 01.06.2022.
//

import SwiftUI

struct HomeView: View {
    @State private var navigate = false
    
    private let textLogo = "Popular photos"
    
    var body: some View {
        NavigationView {
            VStack {
                NavigationLink(
                    destination: SettingsView(),
                    isActive: $navigate,
                    label: {})
                
                PhotosListView()
            }
            .navigationTitle(textLogo)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: { navigate = true }) {                        Image(systemName: "slider.horizontal.3")
                    }
                }
            }
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
