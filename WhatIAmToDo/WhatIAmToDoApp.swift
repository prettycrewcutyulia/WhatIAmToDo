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
    @StateObject var launchScreenState: LaunchScreenStateManager = LaunchScreenStateManager()
    @StateObject var usersDefaultService = UserDefaultsServiceImpl.shared
    
    init() {
            setupDependencies()
        }

    private mutating func setupDependencies() {
        // Defer the resolution of dependencies until after initialization
        
        //_usersDefaultService = State(initialValue: DIContainer.shared.resolve())
        _launchScreenState = StateObject<LaunchScreenStateManager>(wrappedValue: DIContainer.shared.resolve())
    }

    var body: some Scene {
        WindowGroup {
            ZStack {
//                if usersDefaultService.isUserRegistered() {
                    MainTabBar()
                    //.environment(\.locale, Locale(identifier: usersDefaultService?.getCurrentLocale() ?? "ru"))
//                } else {
//                    AuthorizationScreen()
//                }
                if launchScreenState.state != .finished {
                    LaunchScreenView()
                }
            }
            .environment(\.locale, Locale(identifier: usersDefaultService.selectedLanguage))
            .environmentObject(launchScreenState)
            
        }
    }
}
