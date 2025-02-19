//
//  AuthorizationStack.swift
//  WhatIAmToDo
//
//  Created by Юлия Гудошникова on 17.02.2025.
//



import SwiftUI

// Структура для авторизационного стека
struct AuthorizationStack: View {
    @State var email: String = ""
    @State var password: String = ""
    @State private var isForgotPasswordPresented: Bool = false
    var didTapLogin: (AuthRequest) -> String?
    var didTapForgotPassword: (String) -> String?

    var body: some View {
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
                didTapLogin(AuthRequest(email: email, password: password))
            }) {
                Text("Log In")
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.accentColor)
                    .foregroundColor(.white)
                    .cornerRadius(13)
            }
            .disabled(email.isEmpty || password.isEmpty)
            
            // Кнопка "Забыли пароль"
            Button(action: {
                isForgotPasswordPresented.toggle()
            }) {
                Text("Forgot Password?")
                    .frame(maxWidth: .infinity)
                    .foregroundColor(Color.secondary)
            }
            .sheet(isPresented: $isForgotPasswordPresented) {
                EmailInputSheet(onSubmit: { email in
                    didTapForgotPassword(email)
                })
                .presentationDetents([.height(250)])
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

struct EmailInputSheet: View {
    @State private var email: String = ""
    var onSubmit: (String) -> Void
    
    var body: some View {
        NavigationView {
            VStack(alignment: .leading, spacing: 10) {
                Text("Please enter your email")
                
                TextField("Email", text: $email)
                    .padding(20)
                    .background(Color.gray.opacity(0.2))
                    .cornerRadius(12)
                    .textFieldStyle(PlainTextFieldStyle())
                    .autocapitalization(.none) // Отмена автокапитализации
                    .keyboardType(.emailAddress) // Использование клавиатуры для e-mail
                Button("Reset") {
                    onSubmit(email)
                }
                .frame(maxWidth: .infinity)
                .padding()
                .background(Color.accentColor)
                .foregroundColor(.white)
                .cornerRadius(13)
            }
            .navigationBarTitle("Reset Password", displayMode: .inline)
        }
        .padding(.horizontal, 28)
        .padding(.top, 25)
        .background(
            RoundedCornersShape(corners: [.topLeft, .topRight], radius: 33)
                .fill(Color.white)
        )
    }
}
