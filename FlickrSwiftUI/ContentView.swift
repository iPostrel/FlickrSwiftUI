//
//  ContentView.swift
//  FlickrSwiftUI
//
//  Created by Денис on 31.05.2022.
//

import SwiftUI

struct ContentView: View {
    @StateObject var viewRouter = ViewRouter()
    
    var body: some View {
        AuthenticationView().environmentObject(ViewRouter())
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environmentObject(ViewRouter())
    }
}
