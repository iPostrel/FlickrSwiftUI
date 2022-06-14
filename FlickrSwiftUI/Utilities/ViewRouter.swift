//
//  ViewRouter.swift
//  FlickrSwiftUI
//
//  Created by Денис on 01.06.2022.
//

import Foundation
import SwiftUI

class ViewRouter: ObservableObject {
    @KeychainPropertyWrapper(key: Constants.Keychain.oAuthToken, account: Constants.Keychain.account) var userToken
    
    @Published var currentPage: Page = .logInPage {
        didSet {
            if currentPage == .logInPage {
                userToken = nil
            }
        }
    }
    
    init() {
        if let userToken = userToken {
            let userTokenString = String(data: userToken, encoding: .utf8)
            if userTokenString != "" {
                currentPage = .homePage
            }
        }
    }
}

enum Page {
    case signUpPage
    case logInPage
    case homePage
}
