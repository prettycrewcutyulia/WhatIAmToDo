//
//  GoalGPT.swift
//  WhatIAmToDo
//
//  Created by Юлия Гудошникова on 17.03.2025.
//


// Структуры для приема данных
struct GoalGPT: Codable {
    let title: String
}

struct StepGPT: Codable {
    let description: String
}

struct GoalPlan: Codable {
    let goal: GoalGPT
    let steps: [StepGPT]
}

// Структура для AiGoalRequest
struct AiGoalRequest: Codable {
    let context: String
}


// Метод для получения форматированной строки из GoalPlan
extension GoalPlan {
    func formattedDescription() -> String {
        var result = "Цель: \(goal.title)\n\nШаги:\n"
        
        for (index, step) in steps.enumerated() {
            result += "\(index + 1). \(step.description)\n"
        }
        
        return result
    }
}
