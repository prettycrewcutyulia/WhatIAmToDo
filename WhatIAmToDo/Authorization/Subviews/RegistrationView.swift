//
//  RegistrationView.swift
//  WhatIAmToDo
//
//  Created by Юлия Гудошникова on 17.02.2025.
//
import SwiftUI

struct RegistrationView: View {
    
    @State private var username: String = ""
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var confirmPassword: String = ""
    @State private var passwordsMatch: Bool = true
    @State private var match: Bool = false
    private var isLoading: Bool = false
    @State private var errorName: String? = nil
    @State private var isEmailValid: Bool = true
    
    
    @FocusState private var focusedField: Field?
    
    enum Field: Hashable {
        case nickname
        case email
        case password
        case confirmPassword
    }
    
    var onCompleteRegistration: ((RegistrationRequest) -> Void)?
    
    init(onCompleteRegistration: ((RegistrationRequest) -> Void)? = nil) {
        self.onCompleteRegistration = onCompleteRegistration
    }
    
    var body: some View {
        registrationStack
    }
    
    private var registrationStack: some View {
        VStack(spacing: 20) {
            // Поле для ввода имени пользователя
            TextField("User name", text: $username)
                .padding(20)
                .background(Color.gray.opacity(0.2))
                .cornerRadius(12)
                .textFieldStyle(PlainTextFieldStyle())
                .focused($focusedField, equals: .nickname)
                .submitLabel(.next) // Изменение кнопки отправки на клавиатуре
                .onSubmit {
                    focusedField = .email // Переключение фокуса на пароль после ввода
                }
            
            // Поле для ввода электронной почты
            TextField("Email", text: $email, onEditingChanged: { _ in
                self.isEmailValid = self.isValidEmail(self.email)
            })
                .padding(20)
                .background(Color.gray.opacity(0.2))
                .cornerRadius(12)
                .textFieldStyle(PlainTextFieldStyle())
                .autocapitalization(.none) // Отмена автокапитализации
                .keyboardType(.emailAddress) // Использование клавиатуры для e-mail
                .focused($focusedField, equals: .email)
                .submitLabel(.next) // Изменение кнопки отправки на клавиатуре
                .onSubmit {
                    focusedField = .password // Переключение фокуса на пароль после ввода
                }
            
            // Сообщение об ошибке, если email не валиден
            if !isEmailValid {
                Text("Please enter a valid email address.")
                    .foregroundColor(.red)
            }
            
            // Поле для ввода пароля
            SecureField("Password", text: $password)
                .padding(20)
                .background(Color.gray.opacity(0.2))
                .cornerRadius(12)
                .textFieldStyle(PlainTextFieldStyle())
                .focused($focusedField, equals: .password)
                .submitLabel(.next) // Изменение кнопки отправки на клавиатуре
                .onSubmit {
                    focusedField = .confirmPassword // Переключение фокуса на пароль после ввода
                }
            
            // Поле для ввода подтверждения пароля
            SecureField("Confirm password", text: $confirmPassword)
                .padding(20)
                .background(Color.gray.opacity(0.2))
                .cornerRadius(12)
                .textFieldStyle(PlainTextFieldStyle())
                .onChange(of: confirmPassword) { _ in
                    passwordsMatch = password == confirmPassword
                }
                .focused($focusedField, equals: .confirmPassword)
                .submitLabel(.done) // Изменение кнопки отправки на клавиатуре
            
            if !passwordsMatch {
                Text("Passwords do not match")
                    .foregroundColor(.red)
                    .font(.caption)
            }
            
            // Кнопка логина
            Button(action: {
                match = !username.isEmpty && email.isEmpty && password.isEmpty
                if passwordsMatch {
                   onCompleteRegistration?(
                        RegistrationRequest(
                            nickname: username,
                            email: email,
                            password: password
                        )
                    )
                }
            }) {
                Text("Sign Up")
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(passwordsMatch ? Color.accentColor : Color.gray)
                    .foregroundColor(.white)
                    .cornerRadius(13)
            }
            .disabled(!passwordsMatch || username.isEmpty || email.isEmpty || password.isEmpty)
        }
        .padding(.horizontal, 28)
        .padding(.vertical, 33)
        .background(
            RoundedCornersShape(corners: [.topLeft, .topRight], radius: 33)
                .fill(Color.white)
        )
        .onAppear {
            focusedField = .nickname // При появлении вью ставим фокус на поле ввода e-mail
        }
    }
    
    // Функция проверки валидности email
    func isValidEmail(_ email: String) -> Bool {
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        return NSPredicate(format: "SELF MATCHES %@", emailRegex).evaluate(with: email)
    }
}
