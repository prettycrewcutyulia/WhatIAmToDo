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
//        let locale = defaults.string(forKey: localeKey)
//        if locale == nil {
//            defaults.set("en", forKey: localeKey)
//        }
//        
//        return locale ?? "en"
        return selectedLanguage
    }
    
    // Установка локали
    @MainActor func setAnotherLocale() {
        if selectedLanguage == "en" {
//            defaults.set("ru", forKey: localeKey)
            selectedLanguage = "ru"
        } else {
//            defaults.set("en", forKey: localeKey)
            selectedLanguage = "en"
        }
//        defaults.synchronize()
    }
    
    @MainActor func setAnotherLocale(locale: String) {
        if selectedLanguage == locale {
            return
        }
        if locale == "en" {
//            defaults.set("en", forKey: localeKey)
            selectedLanguage = "en"
        } else if locale == "ru" {
//            defaults.set("ru", forKey: localeKey)
            selectedLanguage = "ru"
        } else {
            return
        }
//        defaults.synchronize()
    }
}


protocol UserDefaultsService: ObservableObject {
    // Метод для проверки, зарегистрирован ли пользователь
    func isUserRegistered() -> Bool

    // Метод для установки значения регистрации пользователя
    func setUserRegistered(_ isRegistered: Bool) async

    // Метод для получения текущей локали
    func getCurrentLocale() -> String

    // Метод для установки другой локали по предопределенному правилу
    func setAnotherLocale() async

    // Метод для установки конкретной локали на основе переданного значения
    func setAnotherLocale(locale: String) async
}
