//
//  HomeView.swift
//  WhatIAmToDo
//
//  Created by Юлия Гудошникова on 04.01.2025.
//

import SwiftUI

struct HomeView: View {
    @StateObject private var viewModel = HomeViewModel(taskService: DIContainer.shared.resolve())

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: Constants.spacing) {
                title
                ChooseTaskBar(goal: $viewModel.goal, allGoals: $viewModel.tasks, updateGoal: viewModel.updateGoal) // Bind goal to viewModel
                CalendarView(selectedDates: $viewModel.selectedDates) // Bind selectedDates to viewModel
                
                progressStack
                
                if viewModel.goal?.steps.count ?? -1 > 0
                {
                    taskStepView
                }
            }
            .padding(Constants.paddingInsets)
        }
        .onAppear {
            viewModel.updateData()
        }
        .onDisappear {
            viewModel.updateGoal()
        }
    }
    
    private var title: some View {
        Text("Report")
            .title()
    }
    
    private var progressStack: some View {
        HStack {
            ProgressView(progress: $viewModel.progress)
            Spacer()
            ProgressViewDays(progress: $viewModel.progressDate)
        }
    }
    
    private var taskStepView: some View {
            VStack(alignment: .leading, spacing: 23) {
                Text("Mark your steps")
                    .font(.targetFont(size: 16).width(.expanded))
                    .fontWeight(.heavy)
                    .fontDesign(.rounded)
                    .fontWidth(.expanded)
                    .foregroundStyle(.accent)
                if let goalLet = viewModel.goal {
                    ForEach(goalLet.steps.indices, id: \.self) { index in
                        StepView(item: Binding(
                            get: { goalLet.steps[index] },
                            set: {
                                viewModel.goal?.steps[index] = $0
                                print("set")
                            }
                        ))
                    }
                    .font(.targetFont(size: 16))
                }
            }
            .padding(.horizontal, 35)
            .padding(.vertical, 30)
            .frame(maxWidth: .infinity, alignment: .leading)
            .background(Color.white)
            .cornerRadius(12)
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
