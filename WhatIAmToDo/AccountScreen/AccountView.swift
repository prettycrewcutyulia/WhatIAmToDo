//
//  AccountView.swift
//  WhatIAmToDo
//
//  Created by Юлия Гудошникова on 04.01.2025.
//

import SwiftUI
import Lottie

struct AccountView: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 26) {
            Text("Profile and Settings")
                .font(.targetFont(size: 20.3))
                .fontWeight(.heavy)
                .fontDesign(.rounded)
                .foregroundStyle(Color.accentColor)
            ProfileView()
                .frame(height: 142)
            SettingsView()
            Spacer()
//            LottieView(animation: <#LottieAnimation?#>)
        }
        .padding(20)
    }
}

struct ProfileView: View {
    var name: String = "Yulia G"
    var mail: String = "ilovescat@gmail.com"
    var taskInProgress: String = "3 task on go"
    var taskCompleted: String = "5 tasks completed"
    var body: some View {
        ZStack(alignment: .topLeading) {
            RoundedRectangle(cornerRadius: 12)
                .fill(Color.white)
            HStack {
                Image(systemName: "person.crop.circle.fill")
                    .resizable()
                    .clipShape(.circle)
                    .frame(width: 108, height: 108)
                    .padding(.trailing, 30)
                description
                Spacer()
                iconsBar
            }
            .foregroundStyle(Color.accentColor)
            .padding(.horizontal, 15)
        }
    }
    
    var description: some View {
        VStack(alignment: .leading, spacing: 6) {
            Text(name)
                .font(.targetFont(size: 16))
                .fontWeight(.heavy)
                .fontDesign(.rounded)
                .padding(4)
            
            Text(mail)
                .font(.targetFont(size: 11))
                .foregroundStyle(.hint)
            Text(taskInProgress)
                .font(.targetFont(size: 11))
                .foregroundStyle(.hint)
            Text(taskCompleted)
                .font(.targetFont(size: 11))
                .foregroundStyle(.hint)
        }
    }
    
    var iconsBar: some View {
        VStack {
            Image(systemName: "pencil")
            Spacer()
            Image("LogOut")
        }
        .padding(.vertical, 14)
    }
}

struct SettingView: View {
    var title: String

    var body: some View {
        HStack {
            Text(title)
                .font(.targetFont(size: 16))
                .fontWeight(.heavy)
                .fontDesign(.rounded)
            Spacer()

            Image(systemName: "chevron.right")
        }
        .padding(15)
        .background(Color.white)
        .cornerRadius(12)
    }
}

struct SettingsView: View {
    var body: some View {
        VStack(spacing: 17) {
            SettingView(title: "Notification")
            SettingView(title: "Sync calendar")
            SettingView(title: "Language")
        }
        .foregroundStyle(Color.accentColor)
    }
}

#Preview {
    AccountView()
}
