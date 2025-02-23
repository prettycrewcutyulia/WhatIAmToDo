//
//  AccountViewModel.swift
//  WhatIAmToDo
//
//  Created by Юлия Гудошникова on 19.02.2025.
//
import Combine
import Foundation

class AccountViewModel: ObservableObject {

    @Published var selectedLanguage: String = "ru"
    private var userDefaults: any UserDefaultsService
    
    init(userDefaults: any UserDefaultsService) {
        self.selectedLanguage = userDefaults.getCurrentLocale()
        self.userDefaults = userDefaults
    }
    
    func changeLanguage(_ language: String) {
        Task {
            await userDefaults.setAnotherLocale(locale: language)
            let newLanguage = userDefaults.getCurrentLocale()
            
            DispatchQueue.main.async {
                self.selectedLanguage = newLanguage
            }
        }
    }
    
}
