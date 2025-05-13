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
    @State private var reminders: Set<Reminder> = []
    private var service: ReminderService
    @Environment(\.locale) var locale
    var isConnectedTgt: Bool
    var email: String
    
    init(service: ReminderService, isConnectedTgt: Bool, email: String) {
        self.service = service
        self.isConnectedTgt = isConnectedTgt
        self.email = email
    }

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
        .onAppear {
            getReminders()
        }
        .onDisappear {
            saveReminders()
        }
    }
    
    private func addReminder() {
        switch reminderOption {
        case .day:
            customDays = 1
        case .week:
            customDays = 7
        case .custom:
            break
        }
        if !reminders.contains { $0.daysCount == customDays } {
            reminders.insert(Reminder(reminderId: nil, daysCount: customDays))
        }
        customDays = 1
    }
    
    func openTgBot() {
        if let url = URL(string: "https://t.me/WhatIAmToDoBot?start=\(email)") {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        }
    }

    private func deleteReminder(at element: Reminder) {
        if let id = element.reminderId {
            service.deleteReminder(by: element.reminderId!, completion:  { res in })
        }
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
                        Text("Reminder in")
                        Text("\(reminder.daysCount)")
                        Text("day(s)")
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
    
    private func getReminders() {
        service.getReminders(completion: { result in
            switch result {
            case .success(let res):
                reminders = Set(res)
            default:
                reminders = []
            }
        })
    }
    
    private func saveReminders() {
        for reminder in reminders {
            if reminder.reminderId == nil {
                service.addReminder(reminder) { result in}
            }
        }
    }
}

enum ReminderOption {
    case day
    case week
    case custom
}
