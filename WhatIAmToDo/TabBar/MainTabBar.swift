//
//  MainTabBar.swift
//  WhatIAmToDo
//
//  Created by Юлия Гудошникова on 04.01.2025.
//

import SwiftUI

struct MainTabBar: View {
    @State private var selectedTab = 0

    var body: some View {
            TabView(selection: $selectedTab) {
                HomeView()
                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .leading)
                    .background(Color.background)
                    .padding(.bottom, 10)
                    .tabItem {
                        Image(systemName: "house.fill")
                    }
                    .tag(0)
                AllTasksView()
                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .leading)
                    .background(Color.background)
                    .padding(.bottom, 10)
                    .tabItem {
                        Image(systemName: "bookmark")
                    }
                    .tag(1)
                AccountView()
                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .leading)
                    .background(Color.background)
                    .padding(.bottom, 10)
                    .tabItem {
                        Image(systemName: "person")
                    }
                    .tag(2)
            }
            .background(Color(UIColor.systemBackground).ignoresSafeArea())
            .ignoresSafeArea()
        }
}

#Preview {
    MainTabBar()
}
