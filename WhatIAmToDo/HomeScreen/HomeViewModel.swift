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
    @Published var goal: Goal? {
            didSet {
                updateSelectedDates()
            }
        }
    @Published var tasks: [Goal] = []
    
    private let taskService: TaskService

    init(taskService: TaskService) {
        self.taskService = taskService
        tasks = taskService.tasks
    }
    
    private func updateSelectedDates() {
        guard let goalStartDate = goal?.startDate else { return }
        
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
    }

    func updateData() {
        tasks = taskService.tasks
    }
}
