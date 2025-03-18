//
//  CalendarView.swift
//  WhatIAmToDo
//
//  Created by Юлия Гудошникова on 07.01.2025.
//

import SwiftUI

struct CalendarView: View {
    @Binding var selectedDates: Set<DateComponents>
    
    @StateObject var usersDefaultService = UserDefaultsServiceImpl.shared
    
    var body: some View {
        MultiDatePicker("", selection: $selectedDates)
            .environment(\.locale, Locale.init(identifier: usersDefaultService.selectedLanguage))
            .tint(Color.accentColor)
            .onTapGesture {}
            .disabled(selectedDates.isEmpty)
            .padding()
            .background(Color.white.cornerRadius(Constants.radius))
            .foregroundStyle(Color.accentColor)
    }
}

private enum Constants {
    static let radius: CGFloat = 20
}
