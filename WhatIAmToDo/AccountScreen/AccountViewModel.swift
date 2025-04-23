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
    @Published var isLoginViewPresented: Bool = false
    @Published var selectedImage: UIImage? {
        didSet {
            userDefaults.setImage(selectedImage)
        }
    }
    var name: String = ""
    var mail: String = ""
    var isConnectedTg: Bool = false
    private var userDefaults: any UserDefaultsService
    private var accountService: any AccountService
    
    
    init(userDefaults: any UserDefaultsService, accountService: any AccountService) {
        self.selectedLanguage = userDefaults.getCurrentLocale()
        self.userDefaults = userDefaults
        self.accountService = accountService
        
        let userData = userDefaults.getUserData()
        guard let userData = userData else { return }
        let user = userDefaults.getUserIdAndUserToken()
        guard let userId = user?.userId else { return }
        Task {
            accountService.getTgExist(userId: userId, completion: {res in
                switch res {
                case .success(let success):
                    Task { @MainActor in
                        self.isConnectedTg = true
                    }
                case .failure(let failure):
                    Task { @MainActor in
                        self.isConnectedTg = false
                    }
                }
            })
        }
        self.name = userData.name
        self.mail = userData.email
        self.selectedImage = userDefaults.getImage()
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
    
    func updateAccount() {
        let userData = userDefaults.getUserIdAndUserToken()
        guard let userId = userData?.userId else { return }
        accountService.updateAccount(UpdateAccountRequest(
            userId: userId,
            name: name,
            email: mail
        ), completion: { result in
            switch result {
            case .success:
                print("успешно изменены данные")
            case .failure(let error):
                // Обработка ошибки
                print("Ошибка при удалении учетной записи: \(error.localizedDescription)")
            }
        })
    }
    
    func logout() {
        Task {
            await userDefaults.setUserRegistered(false)
            self.isLoginViewPresented.toggle()
        }
    }
    
    func deleteAccount() {
        let userData = userDefaults.getUserIdAndUserToken()
        guard let userId = userData?.userId else { return }
        accountService.deleteAccount(DeleteAccountRequest(userId: userId), completion: { result in
            switch result {
            case .success:
                Task { @MainActor in
                    await self.userDefaults.setUserRegistered(false)
                    self.isLoginViewPresented.toggle()
                }
            case .failure(let error):
                // Обработка ошибки
                print("Ошибка при удалении учетной записи: \(error.localizedDescription)")
            }
        })
    }
}
