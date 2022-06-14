//
//  LoginView.swift
//  FlickrSwiftUI
//
//  Created by Денис on 31.05.2022.
//

import SwiftUI

struct LoginView: View {
    @EnvironmentObject private var viewRouter: ViewRouter
    
    @State private var logInProcessing = false
    @State private var logInErrorMessage = ""
    
    @State private var email: String = ""
    @State private var password: String = ""
    
    private let textSignUp = "Sign Up"
    private let textError = "Failed creating account:"
    private let textHaveAccount = "Don't have an account?"
    private let textLogIn = "Log In"
    
    var body: some View {
        VStack(spacing: 15) {
            Spacer()
            LogoView()
            WelcomeText()
            Spacer()
            SignInCredentialFields(email: $email, password: $password)
            Button(action: {
                logInUser(userEmail: email, userPassword: password)
            }) {
                if logInProcessing {
                    ProgressView()
                } else {
                    Text(textLogIn)
                        .bold()
                }
            }
            .disabled(isDisabled())
            .frame(maxWidth: .infinity, maxHeight: 50.0)
            .background(.thinMaterial)
            .cornerRadius(10)
            
            if !logInErrorMessage.isEmpty {
                Text("\(textError) \(logInErrorMessage)")
                    .foregroundColor(.red)
            }
            Spacer()
            HStack {
                Text(textHaveAccount)
                Button(action: {
                    withAnimation {
                        viewRouter.currentPage = .signUpPage
                    }
                }) {
                    Text(textSignUp)
                }
            }
            .opacity(0.9)
        }
        .padding()
    }
    
    private func logInUser(userEmail: String, userPassword: String) {
        viewRouter.userToken = userEmail.data(using: .utf8)
        withAnimation {
            viewRouter.currentPage = .homePage
        }
    }
    
    private func isDisabled() -> Bool {
        return !logInProcessing && !email.isEmpty && !password.isEmpty ? false : true
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
} 

private struct SignInCredentialFields: View {
    
    @Binding var email: String
    @Binding var password: String
    
    private let textEmail = "Email"
    private let textPassword = "Password"
    
    private let radius = 10.0
    
    var body: some View {
        Group {
            TextField(textEmail, text: $email)
                .padding()
                .background(.thinMaterial)
                .cornerRadius(radius)
                .textInputAutocapitalization(.never)
            SecureField(textPassword, text: $password)
                .padding()
                .background(.thinMaterial)
                .cornerRadius(radius)
                .padding(.bottom, 30)
        }
    }
}
