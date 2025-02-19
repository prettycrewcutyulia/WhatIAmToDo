//
//  AccountView.swift
//  WhatIAmToDo
//
//  Created by Юлия Гудошникова on 04.01.2025.
//

import SwiftUI
import Lottie

struct AccountView: View {
    @ObservedObject private var viewModel = AccountViewModel()
    var body: some View {
        VStack(alignment: .leading, spacing: 26) {
            Text("Profile and Settings")
                .font(.targetFont(size: 20.3))
                .fontWeight(.heavy)
                .fontDesign(.rounded)
                .foregroundStyle(Color.accentColor)
            ProfileView()
                .frame(height: 142)
            SettingsView(viewModel: viewModel)
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

struct SettingsView: View {
    @ObservedObject private var viewModel: AccountViewModel
    
    init(viewModel: AccountViewModel) {
        self.viewModel = viewModel
    }

    var body: some View {
        VStack(spacing: 17) {
            notificationMenuView
            
            languageMenuView
        }
        .foregroundStyle(Color.accentColor)
    }
    
    var languageMenuView: some View {
        Menu {
            Button(action: {
                viewModel.changeLanguage("en")
            }) {
                HStack {
                    Text("English")
                    if viewModel.selectedLanguage == "en" {
                        Image(systemName: "checkmark")
                    }
                }
            }
            
            Button(action: {
                viewModel.changeLanguage("ru")
            }) {
                HStack {
                    Text("Russian")
                    if viewModel.selectedLanguage == "ru" {
                        Image(systemName: "checkmark")
                    }
                }
            }
        } label: {
            HStack {
                Text("Language")
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
    
    var notificationMenuView: some View {
        HStack {
            Text("Notification")
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

#Preview {
    AccountView()
}
