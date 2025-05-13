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
        
        let serviceTask: any TaskService = TaskServiceImpl(userDefaults: userDefaultsRepository)
        DIContainer.shared.register(serviceTask)
        
        let authenticationService: any AuthorizationService = AuthorizationServiceImpl(taskService: serviceTask);
        DIContainer.shared.register(authenticationService)
        
        let reminderService: any ReminderService = ReminderServiceImpl(userDefaults: userDefaultsRepository)
        DIContainer.shared.register(reminderService)
        
        let accountService: any AccountService = AccountServiceImpl(userDefaults: userDefaultsRepository)
        DIContainer.shared.register(accountService)
        
        let launchService = LaunchScreenStateManager()
        DIContainer.shared.register(launchService)
    }

}
