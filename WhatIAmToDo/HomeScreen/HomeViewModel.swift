//
//  HomeViewModel.swift
//  WhatIAmToDo
//
//  Created by Юлия Гудошникова on 16.03.2025.
//

import SwiftUI

final class HomeViewModel: ObservableObject {
    @Published var date = Date()
    @Published var selectedDates: Set<DateComponents> = []
    @Published var progressDate: String = "⎯"
    @Published var progress: String = "⎯"
    @Published var goal: Goal? {
            didSet {
                updateSelectedDates()
                updateCompletedSteps()
            }
        }
    @Published var tasks: [Goal] = []
    
    private let taskService: TaskService

    init(taskService: TaskService) {
        self.taskService = taskService
        tasks = taskService.tasks
    }
    
    private func updateSelectedDates() {
        guard let goalStartDate = goal?.startDate else {
            selectedDates = []
            progressDate = "⎯"
            return
        }
        
        let calendar = Calendar.current
        var dateComponents = DateComponents()
        var currentDate = goalStartDate
        
        while currentDate <= Date() {
            dateComponents = calendar.dateComponents([.year, .month, .day], from: currentDate)
            selectedDates.insert(dateComponents)
            
            // Переходим на следующий день
            guard let nextDate = calendar.date(byAdding: .day, value: 1, to: currentDate) else { break }
            currentDate = nextDate
        }
        let differenceInDays = goalStartDate.distance(to: Date())
        progressDate = "\(Int(differenceInDays / (60 * 60 * 24)) + 1)"
    }
    
    private func updateCompletedSteps() {
        guard let goal = goal else {
            progress = "⎯"
            return
        }
        if goal.steps.count == 0 {
            progress = "⎯"
            return
        }
        progress = "\(goal.completedSteps)/\(goal.steps.count)"
    }

    func updateData() {
        Task {@MainActor in
            tasks = taskService.tasks
        }
    }
    
    func updateGoal() {
        guard let goal else { return }
        let userDefaults: any UserDefaultsService = DIContainer.shared.resolve()
        taskService.updateGoal(
            id: goal.id,
            goalRequest: GoalRequest(
                userId: userDefaults.getUserIdAndUserToken()?.userId ?? 0,
                title: goal.title,
                categories: goal.categoryId,
                steps: goal.steps.map(StepRequest.init),
                startDate: goal.startDate,
                deadline: goal.deadline
            ),
            completion: { res in
                switch res {
                    case .success:
                    self.updateData()
                default:
                    break
                }
            }
        )
    }
}
