//
//  LaunchScreenView.swift
//  WhatIAmToDo
//
//  Created by Юлия Гудошникова on 07.01.2025.
//


import SwiftUI
import Lottie

struct LaunchScreenView: View {
    @EnvironmentObject private var launchScreenState: LaunchScreenStateManager
    @State private var firstAnimation = false  // Mark 2
    @State private var secondAnimation = false // Mark 2
    @State private var startFadeoutAnimation = false
    @ViewBuilder
    private var backgroundColor: some View {  // Mark 3
        Color.background.ignoresSafeArea()
    }
    
    private let animationTimer = Timer // Mark 5
        .publish(every: 0.5, on: .current, in: .common)
        .autoconnect()
    
    var body: some View {
        ZStack {
            backgroundColor
            LottieView(animation: .named("launchAnimation.json"))
                .playing(loopMode: .loop)
        }.onReceive(animationTimer) { _ in
            updateAnimation()
        }.opacity(startFadeoutAnimation ? 0 : 1)
    }
    
    private func updateAnimation() { // Mark 5
        switch launchScreenState.state {
        case .firstStep:
                   withAnimation(.easeInOut(duration: 0.9)) {
                       firstAnimation.toggle()
                   }
               case .secondStep:
                   if secondAnimation == false {
                       withAnimation(.linear) {
                           self.secondAnimation = true
                           startFadeoutAnimation = true
                       }
                   }
               case .finished:
                   // use this case to finish any work needed
                   break
        }
    }
    
}

struct LaunchScreenView_Previews: PreviewProvider {
    static var previews: some View {
        LaunchScreenView()
            .environmentObject(LaunchScreenStateManager())
    }
}
