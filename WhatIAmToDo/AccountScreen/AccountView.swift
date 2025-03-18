//
//  AccountView.swift
//  WhatIAmToDo
//
//  Created by Юлия Гудошникова on 04.01.2025.
//

import SwiftUI
import Lottie

struct AccountView: View {
    @ObservedObject private var viewModel = AccountViewModel(userDefaults: DIContainer.shared.resolve())
    var body: some View {
        NavigationView {
            VStack(alignment: .leading, spacing: 26) {
                Text("Profile and Settings")
                    .font(.targetFont(size: 20.3))
                    .fontWeight(.heavy)
                    .fontDesign(.rounded)
                    .foregroundStyle(Color.accentColor)
                ProfileView(viewModel: viewModel)
                    .frame(height: 142)
                SettingsView(viewModel: viewModel)
                Spacer()
            }
            .padding(20)
            .background(Color.background)
        }
    }
}

struct ProfileView: View {
    @State private var isEditingName: Bool = false
    @State private var showImagePicker = false
    @ObservedObject private var viewModel: AccountViewModel
    
    init(viewModel: AccountViewModel) {
        self.viewModel = viewModel
    }

    var body: some View {
        ZStack(alignment: .topLeading) {
            RoundedRectangle(cornerRadius: 12)
                .fill(Color.white)
            HStack {
                if let image = viewModel.selectedImage {
                    Image(uiImage: image)
                        .resizable()
                        .clipShape(.circle)
                        .frame(width: 108, height: 108)
                        .padding(.trailing, 30)
                        .onTapGesture {
                            showImagePicker = true
                        }
                } else {
                    Image(systemName: "person.crop.circle.fill")
                        .resizable()
                        .clipShape(.circle)
                        .frame(width: 108, height: 108)
                        .padding(.trailing, 30)
                        .onTapGesture {
                            showImagePicker = true
                        }
                }
                description
                Spacer()
                iconsBar
            }
            .foregroundStyle(Color.accentColor)
            .padding(.horizontal, 15)
        }
        .sheet(isPresented: $showImagePicker) {
            ImagePicker(selectedImage: $viewModel.selectedImage)
                }
    }
    
    var description: some View {
        VStack(alignment: .leading, spacing: 6) {
            if isEditingName {
                TextField("Write your message", text: $viewModel.name)
                    .font(.targetFont(size: 16))
                    .fontWeight(.heavy)
                    .fontDesign(.rounded)
                    .padding(4)
                    .overlay(
                                      RoundedRectangle(cornerRadius: 8)
                                          .stroke(Color.gray, lineWidth: 1)
                                  )
                
                TextField("Write your email", text: $viewModel.mail)
                    .font(.targetFont(size: 11))
                    .foregroundStyle(.hint)
                    .overlay(
                                      RoundedRectangle(cornerRadius: 8)
                                          .stroke(Color.gray, lineWidth: 1)
                                  )
                
            } else {
                Text(viewModel.name)
                    .font(.targetFont(size: 16))
                    .fontWeight(.heavy)
                    .fontDesign(.rounded)
                    .padding(4)
                
                Text(viewModel.mail)
                    .font(.targetFont(size: 11))
                    .foregroundStyle(.hint)
            }
        }
    }
    
    var iconsBar: some View {
        VStack {
            Image(systemName:  isEditingName ? "checkmark" :"pencil")
                .onTapGesture {
                    isEditingName.toggle()
                }
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
        NavigationLink(destination: ReminderView().navigationTitle("")) {
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
//            .onTapGesture {
//                viewModel.openTgBot()
//            }
        }
        .navigationTitle("")
//        .navigationBarHidden(true)
    }
}

#Preview {
    AccountView()
}
