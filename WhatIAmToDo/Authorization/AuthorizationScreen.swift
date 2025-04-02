//
//  AuthoriztionScreen.swift
//  WhatIAmToDo
//
//  Created by Юлия Гудошникова on 16.02.2025.
//

import SwiftUI

struct AuthorizationScreen: View {
    @ObservedObject private var viewModel: AuthorizationViewModel
    
    init() {
        self.viewModel = AuthorizationViewModel(
            userDefaults: DIContainer.shared.resolve(),
            authenticationService: DIContainer.shared.resolve()
        )
    }

    var body: some View {
        ZStack(alignment: .top) {
            Image("LogInPicture")
                .resizable()
                .ignoresSafeArea()
                .frame(maxHeight: .infinity)
            VStack {
                HStack() {
                    Image(systemName: "globe")
                        .onTapGesture {
                            viewModel.changeLanguage()
                        }
                        .foregroundStyle(.white)
                    Spacer()
                    loginButton
                }
                .padding(21)
                Spacer()
                VStack(alignment: .leading) {
                    Text(viewModel.isAuthorized ? "Log in" : "Sign up")
                        .font(.targetFont(size: 40))
                        .fontWeight(.heavy)
                        .fontDesign(.rounded)
                        .foregroundStyle(.white)
                        .padding(.horizontal, 28)
                    Text("Become the best version of yourself, start tracking your goals")
                        .font(.targetFont(size: 16))
                        .fontDesign(.rounded)
                        .foregroundStyle(.white)
                        .padding(.horizontal, 28)
                        .padding(.bottom, 24)
                    if viewModel.isAuthorized == true {
                        AuthorizationStack(
                            didTapLogin: { model in
                                viewModel.login(model: model)
                            },
                            didTapForgotPassword: { email in
                                return viewModel.forgotPassword(email: email)
                            }
                        )
                    } else {
                        RegistrationView(onCompleteRegistration: {
                            model in
                           return viewModel.signup(model: model)
                        })
                    }
                }
                .offset(y: 40)
            }
        }
        .fullScreenCover(
            isPresented: $viewModel.isMainShown,
            content: { MainTabBar() }
        )
    }
    
    
    var loginButton: some View {
        Button(action: {
            viewModel.toggleAuthorization()
        }) {
            Text(viewModel.isAuthorized ? "Sign Up" : "Log in")
                .underline()
                .foregroundColor(.white)
        }
    }
}

#Preview {
    AuthorizationScreen()
}
