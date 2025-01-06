//
//  HomeView.swift
//  WhatIAmToDo
//
//  Created by Юлия Гудошникова on 04.01.2025.
//

import SwiftUI

struct HomeView: View {
    @State private var date = Date()
    @State private var selectedDates: Set<DateComponents> = [DateComponents(year: 2025, month: 1, day: 17), DateComponents(year: 2025, month: 1, day: 18), DateComponents(year: 2025, month: 1, day: 19)]

    var body: some View {
        VStack(alignment: .leading, spacing: Constants.spacing) {
            Text("Report")
                .font(.targetFont(size: 20.3))
                .fontWeight(.heavy)
                .fontDesign(.rounded)
                .foregroundStyle(Color.accentColor)
            ChooseTaskBar()
            MultiDatePicker("Выберите дни", selection: $selectedDates)
                .environment(\.locale, Locale.init(identifier: "us"))
                .tint(Color.accentColor)
                .onTapGesture {}
                .disabled(selectedDates.isEmpty)
            .padding()
            .background(Color.white.cornerRadius(Constants.radius))
            
            HStack {
                ProgressView(progress: "3/8", title: "Progress")
                Spacer()
                ProgressView(progress: "5", title: "Days")
            }
        }
        .padding(Constants.paddingInsets)
    }
}

private enum Constants {
    static let paddingInsets: CGFloat = 20
    static let radius: CGFloat = 20
    static let spacing: CGFloat = 20
}

#Preview {
    HomeView()
}
