//
//  TaskStepsView.swift
//  WhatIAmToDo
//
//  Created by Юлия Гудошникова on 07.01.2025.
//

import SwiftUI
import Combine

struct StepView: View {
    @Binding var item: Step
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            HStack{
                Button(action: { item.isCompleted.toggle() }) {
                    Image(systemName: item.isCompleted ? "checkmark.square.fill" : "square")
                        .resizable()
                        .frame(width: 23, height: 23)
                }
                Text(item.title)
                    .font(.targetFont(size: 16))
                    .lineLimit(nil)
            }
            
            if let deadline = item.deadline {
                DatePicker(
                    "Deadline:",
                    selection: .constant(deadline),
                    displayedComponents: .date
                )
                .disabled(true)
            }
        }
    }
}


