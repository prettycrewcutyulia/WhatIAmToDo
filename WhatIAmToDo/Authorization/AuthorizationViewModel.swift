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
        print("isAuthorized: \(isAuthorized)")
    }
    
    func login() {
        print("login")
    }
    
    func signup() {
        print( "signup")
    }
    
    func forgotPassword() {
        print( "forgotPassword")
    }
    
    func changeLanguage() {
        Task {
            await userDefaults.setAnotherLocale()
        }
        
        print("setAnotherLocale")
    }
}
