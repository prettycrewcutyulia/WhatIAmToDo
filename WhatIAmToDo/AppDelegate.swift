//
//  AppDelegate.swift
//  WhatIAmToDo
//
//  Created by Юлия Гудошникова on 22.02.2025.
//

import UIKit

class AppDelegate: NSObject, UIApplicationDelegate, ObservableObject {

    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil
    ) -> Bool {
        setupDI()

        return true
    }
    
    private func setupDI() {
        let userDefaultsRepository: any UserDefaultsService = UserDefaultsServiceImpl.shared
        DIContainer.shared.register(userDefaultsRepository)
        
        let authenticationService: any AuthorizationService = AuthorizationServiceImpl();
        DIContainer.shared.register(authenticationService)
        
        let accountService: any AccountService = AccountServiceImpl(userDefaults: userDefaultsRepository)
        DIContainer.shared.register(accountService)
        
        let serviceTask: any TaskService = TaskServiceImpl(userDefaults: userDefaultsRepository)
        DIContainer.shared.register(serviceTask)
        
        let launchService = LaunchScreenStateManager()
        DIContainer.shared.register(launchService)
    }

}
