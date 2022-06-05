//
//  ViewRouter.swift
//  FlickrSwiftUI
//
//  Created by Денис on 01.06.2022.
//

import Foundation

class ViewRouter: ObservableObject {
    @Published var currentPage: Page = .logInPage
    
    init() {
        currentPage = UserSettings().username.isEmpty ? .logInPage : .homePage
    }
}

enum Page {
    case signUpPage
    case logInPage
    case homePage
}
