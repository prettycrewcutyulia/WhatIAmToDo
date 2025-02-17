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
    @StateObject var usersDefaultService = UserDefaultsService()
    
    var body: some Scene {
        WindowGroup {
            ZStack {
                AuthorizationScreen()
                    .environment(\.locale, Locale(identifier: usersDefaultService.getCurrentLocale()))
//                MainTabBar()
//                if launchScreenState.state != .finished {
//                    LaunchScreenView()
//                }
            }
            .environmentObject(launchScreenState)
            .environmentObject(usersDefaultService)
            
        }
    }
}
