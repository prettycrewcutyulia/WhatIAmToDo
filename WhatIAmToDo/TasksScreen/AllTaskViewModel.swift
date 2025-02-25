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
    
    @Published var filters: [Category] = [
        Category(id: UUID().uuidString, name: "Work", color: .green),
                Category(id: UUID().uuidString, name: "Personal", color: .blue),
                Category(id: UUID().uuidString, name: "Work", color: .red)
            ]

    var filteredTasks: [Goal] {
        tasks.filter { task in
            (selectedCategory == nil || task.category.contains(where: {$0.id == selectedCategory})) &&
            (queryString.isEmpty || task.name.lowercased().contains(queryString.lowercased()))
        }
    }
    
    private var tasks: [Goal] = []
}
