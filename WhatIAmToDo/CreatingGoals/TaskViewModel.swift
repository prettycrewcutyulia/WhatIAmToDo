//
//  TaskViewModel.swift
//  WhatIAmToDo
//
//  Created by Юлия Гудошникова on 16.03.2025.
//


import SwiftUI

class TaskViewModel: ObservableObject {
    @Published var taskTitle: String
    @Published var steps: [Step]
    @Published var startDate: Date?
    @Published var deadline: Date?
    @Published var newStepTitle: String = ""
    @Published var showNewStepField: Bool = false
    @Published var categories: Set<Int>
    @Published var isBottomSheetPresented = false
    @Published var isErrorShown = false
    
    var filters: [Category]
    let isEditing: Bool
    var goalId: Int?
    let taskService: TaskService
    let userDefaultsService: any UserDefaultsService
    
    init(task: Goal? = nil, taskService: TaskService, userDefaultsService: any UserDefaultsService) {
        if let task = task {
            self.goalId = task.id
            self.taskTitle = task.title
            self.steps = task.steps
            self.startDate = task.startDate
            self.deadline = task.deadline
            self.categories = Set(task.categoryId)
            self.isEditing = true
        } else {
            self.taskTitle = ""
            self.steps = []
            self.startDate = nil
            self.deadline = nil
            self.categories = []
            self.isEditing = false
        }
        
        filters = taskService.filters
        self.taskService = taskService
        self.userDefaultsService = userDefaultsService
    }
    
    func toggleStepCompletion(index: Int) {
        steps[index].isCompleted.toggle()
    }
    
    func addStep() {
        if !newStepTitle.isEmpty {
            steps.append(Step(id: UUID().hashValue, title: newStepTitle))
            newStepTitle = ""
            showNewStepField = false
        }
    }
    
    func deleteStep(index: Int) {
        steps.remove(at: index)
    }
    
    func addStartDate() {
        self.startDate = Date()
    }
    
    func removeStartDate() {
        self.startDate = nil
    }
    
    func addDeadline() {
        self.deadline = Date()
    }
    
    func removeDeadline() {
        self.deadline = nil
    }

    func addStepDeadline(index: Int, deadline: Date) {
        steps[index].deadline = deadline
    }
    
    func removeStepDeadline(index: Int) {
        steps[index].deadline = nil
    }
    
    func saveGoal(dismiss: @escaping () -> Void) {
        var userId = userDefaultsService.getUserIdAndUserToken()?.userId
        guard let userId else {
            self.isErrorShown.toggle()
            return
        }
        taskService.createGoal(
            goalRequest: GoalRequest(
                userId: userId,
                title: taskTitle,
                categories: categories.map{ $0 },
                steps: steps.map{ StepRequest(title: $0.title, isCompleted: $0.isCompleted) },
                startDate: startDate,
                deadline: deadline
            ),
            completion: { res in
                switch res {
                case .success(_):
                    Task { @MainActor in
                        dismiss()
                    }
                case .failure(_):
                    Task{ @MainActor in
                        self.isErrorShown.toggle()
                   }
                }
            }
        )
    }
    
    func updateGoal(dismiss: @escaping () -> Void) {
        if let goalId {
            var userId = userDefaultsService.getUserIdAndUserToken()?.userId
            guard let userId else {
                Task{ @MainActor in
                    self.isErrorShown.toggle()
               }
                return
            }
            taskService.updateGoal(
                id: goalId,
                goalRequest: GoalRequest(
                    userId: userId,
                    title: taskTitle,
                    categories: categories.map{ $0 },
                    steps: steps.map{ StepRequest(title: $0.title, isCompleted: $0.isCompleted) },
                    startDate: startDate,
                    deadline: deadline
                ),
                completion: { res in
                    switch res {
                    case .success(_):
                        Task { @MainActor in
                            dismiss()
                        }
                    case .failure(_):
                        Task{ @MainActor in
                            self.isErrorShown.toggle()
                       }
                    }
                }
            )
        }
    }
    
    func deleteGoal(dismiss: @escaping () -> Void) {
        if let goalId {
            taskService.deleteGoalById(id: goalId, completion: { res in
                switch res {
                case .success(_):
                    Task { @MainActor in
                        dismiss()
                    }
                case .failure(_):
                    Task{ @MainActor in
                        self.isErrorShown.toggle()
                   }
                }
            })
        }
    }
}
