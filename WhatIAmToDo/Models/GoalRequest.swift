//
//  GoalRequest.swift
//  WhatIAmToDo
//
//  Created by Юлия Гудошникова on 17.03.2025.
//
import Foundation

// Структура для моделирования GoalRequest
struct GoalRequest: Codable {
    let userId: String
    let title: String
    let categories: [CategoryRequest]
    let steps: [StepRequest]
    let startDate: Date?
    let deadline: Date?
    
    init(userId: String, title: String, categories: [CategoryRequest], steps: [StepRequest], startDate: Date?, deadline: Date?) {
        self.userId = userId
        self.title = title
        self.categories = categories
        self.steps = steps
        self.startDate = startDate
        self.deadline = deadline
    }
    
    init(userId: String, goal: GoalPlan) {
        self.userId = userId
        self.title = goal.goal.title
        self.categories = []
        self.steps = goal.steps.map(StepRequest.init)
        self.startDate = nil
        self.deadline = nil
    }
}

// Структура для детализации CategoryRequest
struct CategoryRequest: Codable {
    // Добавьте необходимые свойства для каждой категории
    let id: String
}

// Структура для детализации StepRequest
struct StepRequest: Codable {
    // Добавьте необходимые свойства для каждого шага
    let title: String
    let isCompleted: Bool
    
    init(title: String, isCompleted: Bool) {
        self.title = title
        self.isCompleted = isCompleted
    }
    
    init(step: StepGPT) {
        self.title = step.description
        self.isCompleted = false
    }
}

// Структура для UpdateFilterRequest
struct UpdateFilterRequest: Codable {
    let title: String
    let color: String
}
