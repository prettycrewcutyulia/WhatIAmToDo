//
//  AuthorizationViewModel.swift
//  WhatIAmToDo
//
//  Created by Юлия Гудошникова on 17.02.2025.
//

import SwiftUI
import Combine

class AuthorizationViewModel: ObservableObject {
    @Published var isAuthorized: Bool = false
    @Published var isServerErrorShown: Bool = false
    @Published var isClientErrorShown: Bool = false
    @Published var errorMessage = ""
    @Published var isMainShown: Bool = false
    
    private var userDefaults: any UserDefaultsService
    private var authenticationService: any AuthorizationService
    
    init(
        userDefaults: any UserDefaultsService,
        authenticationService: any AuthorizationService
        
    ) {
        self.userDefaults = userDefaults
        self.authenticationService = authenticationService
    }
    
    func toggleAuthorization() {
        isAuthorized.toggle()
    }
    
    func login(model: AuthRequest) {
        authenticationService.login(
            model: model,
            completion: { [weak self] result in
                switch result {
                case .success(let success):
                    Task { [weak self] in
                        await self?.userDefaults.setUserRegistered(true)
                        await self?.userDefaults.setLoginResponseData(response: success)
                        await MainActor.run {
                            isMainShown.toggle()
                        }
                    }
                case .failure(let error):
                    switch error {
                    case .clientError:
                        Task {  [weak self] in
                            await MainActor.run {
                                self?.isClientErrorShown.toggle()
                                self?.errorMessage = "Неверный логин или пароль"
                            }
                        }
                    case .serverError:
                        Task {
                            await MainActor.run {
                                self?.isServerErrorShown.toggle()
                                self?.errorMessage = "Проверьте соединение с интернетом и повторите попытку позже."
                            }
                        }
                    }
                }
            }
        )
    }
    
    func signup(model: RegistrationRequest)  {
        authenticationService.registration(
            model: model,
            completion: { [weak self] result in
                switch result {
                case .success(let success):
                    Task { [weak self] in
                        await self?.userDefaults.setUserRegistered(true)
                        await self?.userDefaults.setLoginResponseData(response: success)
                        isMainShown.toggle()
                    }
                case .failure(let error):
                    switch error {
                    case .clientError:
                        Task { [weak self] in
                           isClientErrorShown.toggle()
                            errorMessage = "Пользователь с таким логином уже существует."
                        }
                    case .serverError:
                        Task {
                            await MainActor.run {
                                self?.isServerErrorShown.toggle()
                                self?.errorMessage = "Проверьте соединение с интернетом и повторите попытку позже."
                            }
                        }
                    }
                }
            }
        )
        print( "signup")
    }
    
    func forgotPassword(email: String) -> String? {
        print( "forgotPassword")
        return "errorrrr"
    }
    
    func changeLanguage() {
        Task {
            await userDefaults.setAnotherLocale()
        }
    }
}
