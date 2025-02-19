//
//  UserDefaultsService.swift
//  WhatIAmToDo
//
//  Created by Юлия Гудошникова on 17.02.2025.
//

import Foundation
import SwiftUI

class UserDefaultsService: ObservableObject {
    static let shared = UserDefaultsService()

    private let defaults = UserDefaults.standard
    
    @AppStorage("selectedLanguage") private var selectedLanguage: String = "en"
    
    // Ключи для UserDefaults
    private let isRegisteredKey = "isRegisteredKey"
    private let localeKey = "localeKey"
    
    private init() {}
    
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
        let locale = defaults.string(forKey: localeKey)
        if locale == nil {
            defaults.set("en", forKey: localeKey)
        }
        
        return locale ?? "en"
    }
    
    // Установка локали
    @MainActor func setAnotherLocale() {
        if defaults.string(forKey: localeKey) == "en" {
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
}
