//
//  AllTaskViewModel.swift
//  WhatIAmToDo
//
//  Created by Юлия Гудошникова on 25.02.2025.
//
import SwiftUI
import Combine

class AllTaskViewModel: ObservableObject {
    @Published var queryString = ""
    @Published var selectedCategory: String?
    @Published var selectedCategoryColor: Color = .background
    
    @Published var filters: [Category]

    var filteredTasks: [Goal] {
        tasks.filter { task in
            (selectedCategory == nil || task.category.contains(where: {$0.id == selectedCategory})) &&
            (queryString.isEmpty || task.title.lowercased().contains(queryString.lowercased()))
        }
    }
    
    @Published var tasks: [Goal] = []
    
    private var taskService: TaskService
    
    init(taskService: TaskService) {
        self.taskService = taskService
        tasks = taskService.tasks
        filters = taskService.filters
    }
    
    func updateData() {
        tasks = taskService.tasks
        filters = taskService.filters
    }
}
