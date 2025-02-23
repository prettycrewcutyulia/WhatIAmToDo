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

        let userDefaultsRepository: any UserDefaultsService = UserDefaultsServiceImpl()

        DIContainer.shared.register(userDefaultsRepository)

        return true
    }

}
