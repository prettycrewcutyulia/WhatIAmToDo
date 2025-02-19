//
//  AccountViewModel.swift
//  WhatIAmToDo
//
//  Created by Юлия Гудошникова on 19.02.2025.
//
import Combine
import Foundation

class AccountViewModel: ObservableObject {
    @Published var selectedLanguage: String = UserDefaultsService.shared.getCurrentLocale()
    
    func changeLanguage(_ language: String) {
        Task {
            await UserDefaultsService.shared.setAnotherLocale(locale: language)
            let newLanguage = UserDefaultsService.shared.getCurrentLocale()
            
            DispatchQueue.main.async {
                self.selectedLanguage = newLanguage
            }
        }
    }
    
}
