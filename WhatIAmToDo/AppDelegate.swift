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
        zeroFetch()

        return true
    }
    
    private func setupDI() {
        let userDefaultsRepository: any UserDefaultsService = UserDefaultsServiceImpl()
        DIContainer.shared.register(userDefaultsRepository)
        
        let serviceTask: any TaskService = TaskServiceImpl()
        DIContainer.shared.register(serviceTask)
        
        let launchService = LaunchScreenStateManager()
        DIContainer.shared.register(launchService)
    }
    
    private func zeroFetch() {
        let taskService: any TaskService = DIContainer.shared.resolve()
        let launchService: LaunchScreenStateManager = DIContainer.shared.resolve()
    
        let dispatchGroup = DispatchGroup()
        var fetchTaskSuccess = false
        dispatchGroup.enter()
        taskService.fetchTasks(completion: { result in
            if case .success(let goals) = result {
                fetchTaskSuccess = true
                dispatchGroup.leave()
            }
        })
        
        var fetchFiltersSuccess = false
        dispatchGroup.enter()
        taskService.fetchFilters(completion: { result in
            if case .success(let filters) = result {
                fetchFiltersSuccess = true
                dispatchGroup.leave()
            }
        })
        dispatchGroup.notify(queue: .main) {
            if fetchTaskSuccess && fetchFiltersSuccess {
                launchService.dismiss()
            }
        }
    }

}
