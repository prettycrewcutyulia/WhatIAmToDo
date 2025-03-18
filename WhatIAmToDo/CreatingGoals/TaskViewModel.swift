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
    @Published var categories: Set<Category>
    @Published var isBottomSheetPresented = false
    
    var filters: [Category]
    let isEditing: Bool
    var goalId: String?
    let taskService: TaskService
    
    init(task: Goal? = nil, taskService: TaskService) {
        if let task = task {
            self.goalId = task.id
            self.taskTitle = task.title
            self.steps = task.steps
            self.startDate = task.startDate
            self.deadline = task.deadline
            self.categories = Set(task.category)
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
    }
    
    func toggleStepCompletion(index: Int) {
        steps[index].isCompleted.toggle()
    }
    
    func addStep() {
        if !newStepTitle.isEmpty {
            steps.append(Step(id: UUID().uuidString, title: newStepTitle))
            newStepTitle = ""
            showNewStepField = false
        }
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
    
    func saveGoal() {
        taskService.createGoal(
            goalRequest: GoalRequest(
                userId: "1",
                title: taskTitle,
                categories: categories.map{ CategoryRequest(id: $0.id) },
                steps: steps.map{ StepRequest(title: $0.title, isCompleted: $0.isCompleted) },
                startDate: startDate,
                deadline: deadline
            ),
            completion: {_ in }
        )
    }
    
    func updateGoal() {
        if let goalId {
            taskService.updateGoal(
                id: goalId,
                goalRequest: GoalRequest(
                    userId: "1",
                    title: taskTitle,
                    categories: categories.map{ CategoryRequest(id: $0.id) },
                    steps: steps.map{ StepRequest(title: $0.title, isCompleted: $0.isCompleted) },
                    startDate: startDate,
                    deadline: deadline
                ),
                completion: {_ in }
            )
        }
    }
}
