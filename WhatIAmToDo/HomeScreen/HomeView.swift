//
//  HomeView.swift
//  WhatIAmToDo
//
//  Created by Юлия Гудошникова on 04.01.2025.
//

import SwiftUI

struct HomeView: View {
    @StateObject private var viewModel = HomeViewModel(taskService: DIContainer.shared.resolve()) // Initialize the view model

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: Constants.spacing) {
                title
                ChooseTaskBar(goal: $viewModel.goal, allGoals: $viewModel.tasks) // Bind goal to viewModel
                CalendarView(selectedDates: $viewModel.selectedDates) // Bind selectedDates to viewModel
                
                progressStack
                
                if let goal = viewModel.goal,
                   goal.steps.count > 0
                {
                    TaskStepsView(checkListData: goal.steps)
                }
            }
            .padding(Constants.paddingInsets)
        }
        .onAppear {
            viewModel.updateData()
        }
    }
    
    private var title: some View {
        Text("Report")
            .title()
    }
    
    private var progressStack: some View {
        HStack {
            if let completedSteps = viewModel.goal?.completedSteps,
               let stepsCount = viewModel.goal?.steps.count,
               stepsCount != 0
            {
                ProgressView(progress: "\(completedSteps)/\(stepsCount)")
            } else {
                ProgressView(progress: nil)
            }
            Spacer()
            if let differenceInDays = viewModel.goal?.startDate?.distance(to: Date()) {
                ProgressViewDays(progress: "\(Int(differenceInDays / (60 * 60 * 24)) + 1)")
            } else {
                ProgressView(progress: nil)
            }
        }
    }
}

private enum Constants {
    static let paddingInsets: CGFloat = 20
    static let spacing: CGFloat = 20
    static let steppersWidth: CGFloat = 311
}

#Preview {
    HomeView()
}
