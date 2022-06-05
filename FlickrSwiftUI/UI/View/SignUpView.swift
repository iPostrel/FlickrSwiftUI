//
//  SignUpView.swift
//  FlickrSwiftUI
//
//  Created by Денис on 01.06.2022.
//

import SwiftUI

struct SignUpView: View {
    @EnvironmentObject private var viewRouter: ViewRouter
    @ObservedObject private var userSettings = UserSettings()
    
    @State private var email = ""
    @State private var password = ""
    @State private var passwordConfirmation = ""
    
    @State private var signUpProcessing = false
    @State private var signUpErrorMessage = ""
    
    private let textSignUp = "Sign Up"
    private let textError = "Failed creating account:"
    private let textHaveAccount = "Already have an account?"
    private let textLogIn = "Log In"
    
    var body: some View {
        VStack(spacing: 15) {
            LogoView()
            WelcomeText()
            Spacer()
            SignUpCredentialFields(email: $email, password: $password, passwordConfirmation: $passwordConfirmation)
            Button(action: {
                signUpUser(userEmail: email, userPassword: password)
            }) {
                if signUpProcessing {
                    ProgressView()
                } else {
                    Text(textSignUp)
                        .bold()
                }
            }
            .disabled(isDisabled())
            .frame(maxWidth: .infinity, maxHeight: 50.0)
            .background(.thinMaterial)
            .cornerRadius(10)
            
            if !signUpErrorMessage.isEmpty {
                Text("\(textError) \(signUpErrorMessage)")
                    .foregroundColor(.red)
            }
            Spacer()
            HStack {
                Text(textHaveAccount)
                Button(action: {
                    withAnimation {
                        viewRouter.currentPage = .logInPage
                    }
                }) {
                    Text(textLogIn)
                }
            }
            .opacity(0.9)
        }
        .padding()
    }
    
    private func signUpUser(userEmail: String, userPassword: String) {
        userSettings.username = userEmail
        withAnimation {
            viewRouter.currentPage = .homePage
        }
    }
    
    private func isDisabled() -> Bool {
        return !signUpProcessing && !email.isEmpty && !password.isEmpty && !passwordConfirmation.isEmpty && password == passwordConfirmation ? false : true
    }
}

struct SignUpView_Previews: PreviewProvider {
    static var previews: some View {
        SignUpView()
    }
}

private struct SignUpCredentialFields: View {
    @Binding var email: String
    @Binding var password: String
    @Binding var passwordConfirmation: String
    
    private let textEmail = "Email"
    private let textPassword = "Password"
    private let textConfirmPassword = "Confirm Password"
    
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
            SecureField(textConfirmPassword, text: $passwordConfirmation)
                .padding()
                .background(.thinMaterial)
                .cornerRadius(radius)
                .border(Color.red, width: passwordConfirmation != password ? 1 : 0)
                .padding(.bottom, 30)
        }
    }
}
