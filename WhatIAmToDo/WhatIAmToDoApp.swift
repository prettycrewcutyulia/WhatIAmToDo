//
//  WhatIAmToDoApp.swift
//  WhatIAmToDo
//
//  Created by Юлия Гудошникова on 03.01.2025.
//

import SwiftUI

@main
struct WhatIAmToDoApp: App {
    @StateObject var launchScreenState = LaunchScreenStateManager()
    @StateObject var usersDefaultService = UserDefaultsService.shared
    
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
            .environment(\.locale, Locale(identifier: usersDefaultService.getCurrentLocale()))
            .environmentObject(launchScreenState)
            .environmentObject(usersDefaultService)
            
        }
    }
}
