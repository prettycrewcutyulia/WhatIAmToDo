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
    
    init(task: Goal? = nil, taskService: TaskService) {
        if let task = task {
            self.taskTitle = task.name
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
    }
    
    func toggleStepCompletion(index: Int) {
        steps[index].isCompleted.toggle()
    }
    
    func addStep() {
        if !newStepTitle.isEmpty {
            steps.append(Step(title: newStepTitle))
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
}
