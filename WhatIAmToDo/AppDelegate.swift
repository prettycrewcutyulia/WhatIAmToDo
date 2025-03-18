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
        
        let serviceTask: any TaskService = TaskServiceImpl()
        DIContainer.shared.register(serviceTask)
        
        let launchService = LaunchScreenStateManager()
        DIContainer.shared.register(launchService)
    }

}
