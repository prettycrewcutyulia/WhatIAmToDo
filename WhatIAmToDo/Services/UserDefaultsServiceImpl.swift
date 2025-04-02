//
//  UserDefaultsService.swift
//  WhatIAmToDo
//
//  Created by Юлия Гудошникова on 17.02.2025.
//

import Foundation
import SwiftUI

class UserDefaultsServiceImpl: UserDefaultsService {
    
    static let shared = UserDefaultsServiceImpl()
    
    @AppStorage("selectedLanguage") var selectedLanguage: String = "en"
    
    // Ключи для UserDefaults
    private let isRegisteredKey = "isRegisteredKey"
    private let localeKey = "localeKey"
    private let defaults = UserDefaults.standard
    private let userIdKey = "userIdKey"
    private let tokenKey = "tokenKey"
    private let nameKey = "nameKey"
    private let emailKey = "emailKey"
    
    private init() {
        selectedLanguage = UserDefaults.standard.string(forKey: localeKey) ?? "en"
    }
    
    // Проверка, зарегистрирован ли пользователь
    func isUserRegistered() -> Bool {
        return defaults.bool(forKey: isRegisteredKey)
    }
    
    // Установка значения регистрации пользователя
    @MainActor func setUserRegistered(_ isRegistered: Bool) {
        defaults.set(isRegistered, forKey: isRegisteredKey)
    }
    
    // Получение текущей локали
    func getCurrentLocale() -> String {
        selectedLanguage
    }
    
    // Установка локали
    @MainActor func setAnotherLocale() {
        if selectedLanguage == "en" {
            defaults.set("ru", forKey: localeKey)
            selectedLanguage = "ru"
        } else {
            defaults.set("en", forKey: localeKey)
            selectedLanguage = "en"
        }
        defaults.synchronize()
    }
    
    @MainActor func setAnotherLocale(locale: String) {
        if selectedLanguage == locale {
            return
        }
        if locale == "en" {
            defaults.set("en", forKey: localeKey)
            selectedLanguage = "en"
        } else if locale == "ru" {
            defaults.set("ru", forKey: localeKey)
            selectedLanguage = "ru"
        } else {
            return
        }
        defaults.synchronize()
    }
    
    @MainActor func setLoginResponseData(response: LoginResponse) async {
        defaults.set(response.id, forKey: userIdKey)
        defaults.set(response.token, forKey: tokenKey)
        defaults.set(response.name, forKey: nameKey)
        defaults.set(response.email, forKey: emailKey)
        
        defaults.synchronize()
    }
    
    func getUserIdAndUserToken() -> (userId: Int, userToken: String)? {
        let userId = defaults.integer(forKey: userIdKey)
        let token = defaults.string(forKey: tokenKey)
        
        if userId > 0, let token {
            return (userId, token)
        }
        
        return nil
    }
    
    func getUserData() -> (name: String, email: String)? {
        let name = defaults.string(forKey: nameKey) ?? ""
        let email = defaults.string(forKey: emailKey) ?? ""
        
        if !name.isEmpty, !email.isEmpty {
            return (name, email)
        }
        
        return nil
    }
    
}
