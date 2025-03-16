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
}
