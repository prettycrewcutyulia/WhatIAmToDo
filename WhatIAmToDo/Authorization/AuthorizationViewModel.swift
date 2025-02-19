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
    
    // Зависимость от UserDefaultsService
    private var userDefaults: UserDefaultsService = UserDefaultsService.shared
    
    func toggleAuthorization() {
        isAuthorized.toggle()
    }
    
    func login(model: AuthRequest) -> String? {
        print("login")
        return "errorrrr"
    }
    
    func signup(model: RegistrationRequest) -> String?  {
        print( "signup")
        return "errorrrr"
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
