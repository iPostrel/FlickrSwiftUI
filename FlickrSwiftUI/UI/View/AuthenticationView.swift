//
//  AuthenticationView.swift
//  FlickrSwiftUI
//
//  Created by Денис on 01.06.2022.
//

import SwiftUI

struct AuthenticationView: View {
    @StateObject var viewRouter = ViewRouter()
    @StateObject var flickrServices = FlickrServices()
    
    var body: some View {
        RedirectionView()
            .environmentObject(viewRouter)
            .environmentObject(flickrServices)
    }
}

struct AuthenticationView_Previews: PreviewProvider {
    static var previews: some View {
        AuthenticationView()
            .environmentObject(ViewRouter())
            .environmentObject(FlickrServices())
    }
}
