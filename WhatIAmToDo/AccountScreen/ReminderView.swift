//
//  ReminderView.swift
//  WhatIAmToDo
//
//  Created by Юлия Гудошникова on 17.03.2025.
//


import SwiftUI

struct ReminderView: View {
    @State private var reminderOption: ReminderOption = .day
    @State private var customDays: Int = 1
    @State private var reminders: Set<String> = []
    @Environment(\.locale) var locale
    var isConnectedTgt: Bool
    var email: String

    var body: some View {
        NavigationView {
            if isConnectedTgt {
                connectedView
                    .background(Color.background)
            } else {
                
                disconnectedView
                    .background(Color.background)
            }
        }
        .navigationTitle("")
    }

    private func addReminder() {
        let reminderText: String
        switch reminderOption {
        case .day:
            reminderText = String(format: NSLocalizedString("Reminder in %d days", comment: "A reminder that will occur in a specified number of days"), 1)
        case .week:
            reminderText = NSLocalizedString("Reminder in 1 week", comment: "A reminder that will occur in a specified number of days")
        case .custom:
            reminderText = String(format: NSLocalizedString("Reminder in %d days", comment: "A reminder that will occur in a specified number of days"), customDays)
        }
        if !reminders.contains(reminderText) {
            
        }
        reminders.insert(reminderText)
    }
    
    func openTgBot() {
        if let url = URL(string: "https://t.me/WhatIAmToDoBot?start=\(email)") {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        }
    }

    private func deleteReminder(at element: String) {
        reminders.remove(element)
    }
    
    private var disconnectedView: some View {
        VStack {
            Spacer()
            Text("Connect Telegram to receive reminders")
            Button(action: openTgBot) {
                Text("Connect Telegram")
                    .fontWeight(.bold)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(.accent)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
            .padding()
            Spacer()
        }
    }
    
    private var connectedView: some View {
        VStack {
            Picker(selection: $reminderOption, label: Text("Set Reminder")) {
                Text("In 1 Day").tag(ReminderOption.day)
                Text("In 1 Week").tag(ReminderOption.week)
                Text("Custom Days").tag(ReminderOption.custom)
            }
            .pickerStyle(SegmentedPickerStyle())
            .padding()
            .overlay(
                RoundedRectangle(cornerRadius: 8)
                    .stroke(Color.gray, lineWidth: 1)
            )
            .padding()
            
            if reminderOption == .custom {
                HStack {
                    Text("Days:")
                    TextField("Enter number of days", value: $customDays, formatter: NumberFormatter())
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .frame(width: 100)
                        .keyboardType(.numberPad)
                }
                .padding()
            }
            
            Button(action: addReminder) {
                Text("Add Reminder")
                    .fontWeight(.bold)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(.accent)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
            .padding()
            
            VStack(alignment: .leading) {
                ForEach(Array(reminders), id: \.self) { reminder in
                    HStack {
                        Text(reminder)
                        Spacer()
                        Image(systemName: "trash")
                            .onTapGesture { deleteReminder(at: reminder) }
                    }
                    .padding()
                }
            }
            .foregroundStyle(Color.accentColor)
            .frame(maxWidth: .infinity, alignment: .leading)
            .background(Color.white) // задает белый фон
            .cornerRadius(10)
            .padding()
            
            Spacer()
        }
    }
}

enum ReminderOption {
    case day
    case week
    case custom
}

//struct ReminderView_Previews: PreviewProvider {
//    static var previews: some View {
//        ReminderView()
//    }
//}
