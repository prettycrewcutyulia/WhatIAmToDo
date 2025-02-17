//
//  CalendarView.swift
//  WhatIAmToDo
//
//  Created by Юлия Гудошникова on 07.01.2025.
//

import SwiftUI

struct CalendarView: View {
    @Binding var selectedDates: Set<DateComponents>
    
    var body: some View {
        MultiDatePicker("Выберите дни", selection: $selectedDates)
            .environment(\.locale, Locale.init(identifier: "us"))
            .tint(Color.accentColor)
            .onTapGesture {}
            .disabled(selectedDates.isEmpty)
            .padding()
            .background(Color.white.cornerRadius(Constants.radius))
    }
}

private enum Constants {
    static let radius: CGFloat = 20
}
