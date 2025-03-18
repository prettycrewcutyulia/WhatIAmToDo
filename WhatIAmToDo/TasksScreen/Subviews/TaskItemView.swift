//
//  TaskItemView.swift
//  WhatIAmToDo
//
//  Created by Юлия Гудошникова on 24.02.2025.
//
import SwiftUI

struct TaskItemView: View {
    
    var goal: Goal
    
    var body: some View {
        NavigationLink(destination: AddEditTaskView(task: goal)) {
            VStack(alignment: .leading) {
                HStack {
                    Spacer()
                    ForEach(goal.category) { category in
                        category.color
                            .frame(width: 11, height: 11)
                            .cornerRadius(3)
                    }
                }
                
                Text(goal.title)
                    .font(.targetFont(size: 16))
                    .fontWeight(.heavy)
                    .fontDesign(.rounded)
                    .foregroundStyle(Color.accentColor)
                Spacer()
                
                ForEach(goal.steps.count > 4 ? Array(goal.steps[0..<4]) : goal.steps) { step in
                    Text(goal.title)
                        .font(.targetFont(size: 16))
                        .foregroundStyle(.hint)
                        .lineLimit(1)
                }
            }
            .padding(15)
            .frame(width: 147, height: 142)
            .background(Color.white)
            .cornerRadius(12)
        }
    }
}
