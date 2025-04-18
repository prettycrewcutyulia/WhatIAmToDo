//
//  AccountViewModel.swift
//  WhatIAmToDo
//
//  Created by Юлия Гудошникова on 19.02.2025.
//
import Combine
import Foundation
import UIKit

class AccountViewModel: ObservableObject {

    @Published var selectedLanguage: String = "ru"
    @Published var isLoggedIn: Bool = false
    @Published var selectedImage: UIImage?
    var name: String = "Yulia G"
    var mail: String = "ilovescat@gmail.com"
    private var userDefaults: any UserDefaultsService
    
    init(userDefaults: any UserDefaultsService) {
        self.selectedLanguage = userDefaults.getCurrentLocale()
        self.userDefaults = userDefaults
        
        let userData = userDefaults.getUserData()
        guard let userData = userData else { return }
        self.name = userData.name
        self.mail = userData.email
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
    
    func openTgBot() {
        // TODO: Встроить норм ссылку
        if let url = URL(string: "tg://resolve?domain=/WhatIAmToDoBot&start=\(mail)") {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        }
    }
}
