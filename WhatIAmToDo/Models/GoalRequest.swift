//
//  GoalRequest.swift
//  WhatIAmToDo
//
//  Created by Юлия Гудошникова on 17.03.2025.
//
import Foundation

// Структура для моделирования GoalRequest
struct GoalRequest: Codable {
    let userId: Int
    let title: String
    let categoriesId: [Int]
    let steps: [StepRequest]
    let startDate: Date?
    let deadline: Date?
    
    init(userId: Int, title: String, categories: [Int], steps: [StepRequest], startDate: Date?, deadline: Date?) {
        self.userId = userId
        self.title = title
        self.categoriesId = categories
        self.steps = steps
        self.startDate = startDate
        self.deadline = deadline
    }
    
    init(userId: Int, goal: GoalPlan) {
        self.userId = userId
        self.title = goal.goal.title
        self.categoriesId = []
        self.steps = goal.steps.map(StepRequest.init)
        self.startDate = nil
        self.deadline = nil
    }
}

// Структура для детализации CategoryRequest
struct CategoryRequest: Codable {
    // Добавьте необходимые свойства для каждой категории
    let id: Int
}

// Структура для детализации StepRequest
struct StepRequest: Codable {
    let stepId: Int?
    let title: String
    let isCompleted: Bool
    let deadline: Date?
    
    init(title: String, isCompleted: Bool) {
        self.title = title
        self.isCompleted = isCompleted
        stepId = nil
        deadline = nil
    }
    
    init(step: StepGPT) {
        self.title = step.description
        self.isCompleted = false
        stepId = nil
        deadline = nil
    }
    
    init(step: Step) {
        stepId = step.id
        title = step.title
        isCompleted = step.isCompleted
        deadline = step.deadline
    }
}

// Структура для UpdateFilterRequest
struct UpdateFilterRequest: Codable {
    let id: Int?
    let title: String
    let color: String
}
