//
//  AuthoriztionScreen.swift
//  WhatIAmToDo
//
//  Created by Юлия Гудошникова on 16.02.2025.
//

import SwiftUI

struct AuthorizationScreen: View {
    @EnvironmentObject private var userDefaults: UserDefaultsService
    @StateObject private var viewModel = AuthorizationViewModel()
    @State private var email: String = ""
    @State private var password: String = ""

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
                        authorizationStack
                    } else {
                        registrationStack
                    }
                }
                .offset(y: 40)
            }
        }
        .onAppear {
            viewModel.setup(userDefaults: userDefaults)
        }
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
    
    var registrationStack: some View {
        VStack(spacing: 20) {
            // Поле для ввода имени пользователя
            TextField("User name", text: $email)
                .padding(20)
                .background(Color.gray.opacity(0.2))
                .cornerRadius(12)
                .textFieldStyle(PlainTextFieldStyle())

               
            // Поле для ввода электронной почты
            TextField("Email", text: $email)
                .padding(20)
                .background(Color.gray.opacity(0.2))
                .cornerRadius(12)
                .textFieldStyle(PlainTextFieldStyle())
                .autocapitalization(.none) // Отмена автокапитализации
                .keyboardType(.emailAddress) // Использование клавиатуры для e-mail
            
            // Поле для ввода пароля
            SecureField("Password", text: $password)
                .padding(20)
                .background(Color.gray.opacity(0.2))
                .cornerRadius(12)
                .textFieldStyle(PlainTextFieldStyle())
            
            // Поле для ввода пароля
            SecureField("Confirm password", text: $password)
                .padding(20)
                .background(Color.gray.opacity(0.2))
                .cornerRadius(12)
                .textFieldStyle(PlainTextFieldStyle())
            
            // Кнопка логина
            Button(action: {
                // Действие при нажатии на кнопку
                print("Email: \(email), Password: \(password)")
            }) {
                Text("Sign Up")
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.accentColor)
                    .foregroundColor(.white)
                    .cornerRadius(13)
            }
        }
        .padding(.horizontal, 28)
        .padding(.vertical, 33)
        .background(
            RoundedCornersShape(corners: [.topLeft, .topRight], radius: 33)
                .fill(Color.white)
        )
    }
    
    var authorizationStack: some View {
        VStack(spacing: 20) {
            // Поле для ввода электронной почты
            TextField("Email", text: $email)
                .padding(20)
                .background(Color.gray.opacity(0.2))
                .cornerRadius(12)
                .textFieldStyle(PlainTextFieldStyle())
                .autocapitalization(.none) // Отмена автокапитализации
                .keyboardType(.emailAddress) // Использование клавиатуры для e-mail
            
            // Поле для ввода пароля
            SecureField("Password", text: $password)
                .padding(20)
                .background(Color.gray.opacity(0.2))
                .cornerRadius(12)
                .textFieldStyle(PlainTextFieldStyle())
            // Кнопка логина
            Button(action: {
                // Действие при нажатии на кнопку
                print("Email: \(email), Password: \(password)")
            }) {
                Text("Log In")
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.accentColor)
                    .foregroundColor(.white)
                    .cornerRadius(13)
            }
            
            // Forgot Password Button
            Button(action: {
                viewModel.forgotPassword()
            }) {
                Text("Forgot Password?")
                    .frame(maxWidth: .infinity)
                    .foregroundColor(Color.secondary)
            }
        }
        .padding(.horizontal, 28)
        .padding(.vertical, 33)
        .background(
            RoundedCornersShape(corners: [.topLeft, .topRight], radius: 33)
                .fill(Color.white)
        )
    }
}

struct RoundedCornersShape: Shape {
    let corners: UIRectCorner
    let radius: CGFloat
    
    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect,
                                byRoundingCorners: corners,
                                cornerRadii: CGSize(width: radius, height: radius))
        return Path(path.cgPath)
    }
}

#Preview {
    AuthorizationScreen()
}
