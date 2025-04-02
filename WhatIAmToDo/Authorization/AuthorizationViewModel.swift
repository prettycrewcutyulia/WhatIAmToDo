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
    @Published var isErrorShown: Bool = false
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
                        isMainShown.toggle()
                    }
                case .failure(let failure):
                    Task {
                      await MainActor.run {
                       self?.isErrorShown.toggle()
                      }
                     }
                }
            }
        )
        print("login")
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
                case .failure(_):
                    Task {
                      await MainActor.run {
                       self?.isErrorShown.toggle()
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
