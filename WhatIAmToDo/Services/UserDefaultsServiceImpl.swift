//
//  UserDefaultsService.swift
//  WhatIAmToDo
//
//  Created by Юлия Гудошникова on 17.02.2025.
//

import Foundation
import SwiftUI

class UserDefaultsServiceImpl: UserDefaultsService {

    private let defaults = UserDefaults.standard
    
    @AppStorage("selectedLanguage") private var selectedLanguage: String = "en"
    
    // Ключи для UserDefaults
    private let isRegisteredKey = "isRegisteredKey"
    private let localeKey = "localeKey"
    
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
        return selectedLanguage
    }
    
    // Установка локали
    @MainActor func setAnotherLocale() {
        if selectedLanguage == "en" {
            selectedLanguage = "ru"
        } else {
            selectedLanguage = "en"
        }
    }
    
    @MainActor func setAnotherLocale(locale: String) {
        if selectedLanguage == locale {
            return
        }
        if locale == "en" {
            selectedLanguage = "en"
        } else if locale == "ru" {
            selectedLanguage = "ru"
        } else {
            return
        }
    }
}
