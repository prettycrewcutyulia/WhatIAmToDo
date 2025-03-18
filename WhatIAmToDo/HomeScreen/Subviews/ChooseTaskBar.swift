//
//  ChooseTaskBar.swift
//  WhatIAmToDo
//
//  Created by Юлия Гудошникова on 04.01.2025.
//

import SwiftUI

struct ChooseTaskBar: View {
    @Binding var goal: Goal?
    @Binding var allGoals: [Goal]
    
    var body: some View {
        Menu {
            // Loop through allGoals to display each as a menu item
            ForEach(allGoals, id: \.self) { eachGoal in
                Button(action: {
                    goal = eachGoal
                }) {
                    HStack {
                        Text(eachGoal.title)
                        if goal == eachGoal {
                            Image(systemName: "checkmark")
                        }
                    }
                }
            }
        } label: {
            HStack {
                Text(goal?.title ?? NSLocalizedString("Choose your task", comment: "Prompt to choose a task"))
                    .font(.system(size: 16))
                    .fontWeight(goal?.title == nil ? .light : .bold)
                    .foregroundColor(goal?.title == nil ? .gray : .accent)
                Spacer()
                Image(systemName: "chevron.down")
                    .fontWeight(.heavy)
                    .tint(Color.accentColor)
            }
            .padding()
            .background(Color.white)
            .cornerRadius(20)
        }
    }
}

