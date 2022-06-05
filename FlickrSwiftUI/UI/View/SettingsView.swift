//
//  SettingsView.swift
//  FlickrSwiftUI
//
//  Created by Денис on 01.06.2022.
//

import SwiftUI

struct SettingsView: View {
    @EnvironmentObject private var viewRouter: ViewRouter
    @ObservedObject private var userSettings = UserSettings()
    
    private let textLogo = "Settings"
    private let textLogOut = "Log out of your account"
    private let textSignOut = "Sign Out"
    
    var body: some View {
        VStack {
            Text(textLogOut)
                .padding()
            Button(textSignOut) {
                signOutUser()
            }
        }
        .navigationTitle(textLogo)
    }
    
    func signOutUser() {
        userSettings.username = ""
        withAnimation {
            viewRouter.currentPage = .logInPage
        }
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
