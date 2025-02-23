//
//  WhatIAmToDoApp.swift
//  WhatIAmToDo
//
//  Created by Юлия Гудошникова on 03.01.2025.
//

import SwiftUI

@main
struct WhatIAmToDoApp: App {
    @UIApplicationDelegateAdaptor private var appDelegate: AppDelegate
    @StateObject var launchScreenState = LaunchScreenStateManager()
    @State var usersDefaultService: (any UserDefaultsService)?/* = DIContainer.shared.resolve()*/
    
    init() {
            setupDependencies()
        }

    private mutating func setupDependencies() {
            // Defer the resolution of dependencies until after initialization
            _usersDefaultService = State(initialValue: DIContainer.shared.resolve())
        }

    var body: some Scene {
        WindowGroup {
            ZStack {
//                if usersDefaultService.isUserRegistered() {
                    MainTabBar()
//                } else {
//                    AuthorizationScreen()
//                }
//                if launchScreenState.state != .finished {
//                    LaunchScreenView()
//                }
            }
            .environment(\.locale, Locale(identifier: usersDefaultService?.getCurrentLocale() ?? "ru"))
            .environmentObject(launchScreenState)
            
        }
    }
}
