//
//  TaskItemView.swift
//  WhatIAmToDo
//
//  Created by Юлия Гудошникова on 24.02.2025.
//
import SwiftUI

struct TaskItemView: View {
    
    var goal: Goal
    var filters: [Category]
    
    var body: some View {
        NavigationLink(destination: AddEditTaskView(task: goal)) {
            VStack(alignment: .leading) {
                HStack {
                    Text(goal.title)
                        .font(.targetFont(size: 16))
                        .fontWeight(.heavy)
                        .fontDesign(.rounded)
                        .foregroundStyle(Color.accentColor)
                        .lineLimit(3)
                        .multilineTextAlignment(.leading)
                    Spacer()
                    ForEach(goal.categoryId, id: \.self) { category in
                        filters.filter { $0.id == category }.first?.color
                            .frame(width: 11, height: 11)
                            .cornerRadius(3)
                    }
                }
                ForEach(goal.steps.count > 0 ? Array(goal.steps[0..<min(2, goal.steps.count)]) : goal.steps) { step in
                    Text(step.title)
                        .font(.targetFont(size: 16))
                        .foregroundStyle(.hint)
                        .lineLimit(1)
                }
            }
            .padding(.horizontal, 15)
            .padding(.bottom, 15)
            .padding(.top, 10)
            .frame(width: 147, height: 142)
            .background(Color.white)
            .cornerRadius(12)
        }
    }
}
