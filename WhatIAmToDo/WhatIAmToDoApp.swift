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
    
    var body: some Scene {
        WindowGroup {
            ZStack {
                MainTabBar()
                if launchScreenState.state != .finished {
                    LaunchScreenView()
                }
            }
            .environmentObject(launchScreenState)
        }
    }
}
