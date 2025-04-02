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
        _launchScreenState = StateObject<LaunchScreenStateManager>(wrappedValue: DIContainer.shared.resolve())
    }

    var body: some Scene {
        WindowGroup {
            ZStack {
                if launchScreenState.state == .secondStep || launchScreenState.state == .finished {
                    if usersDefaultService.isUserRegistered() {
                        MainTabBar()
                    } else {
                        AuthorizationScreen()
                    }
                }
                if launchScreenState.state != .finished {
                    LaunchScreenView()
                        .onAppear {
                            launchScreenState.start()
                        }
                }
            }
            .environment(\.locale, Locale(identifier: usersDefaultService.selectedLanguage))
            .environmentObject(launchScreenState)
            
        }
    }
}
