//
//  RedirectionView.swift
//  FlickrSwiftUI
//
//  Created by Денис on 01.06.2022.
//

import SwiftUI

struct RedirectionView: View {
    @EnvironmentObject var viewRouter: ViewRouter
    
    var body: some View {
        switch viewRouter.currentPage {
        case .signUpPage:
            SignUpView()
        case .logInPage:
            LoginView()
        case .homePage:
            HomeView()
        }
    }
}

struct RedirectionView_Previews: PreviewProvider {
    static var previews: some View {
        RedirectionView()
    }
}
