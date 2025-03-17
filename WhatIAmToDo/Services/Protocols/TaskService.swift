//
//  TaskService.swift
//  WhatIAmToDo
//
//  Created by Юлия Гудошникова on 25.02.2025.
//

protocol TaskService {
    // Массив задач
    var tasks: [Goal] { get set }

    // Массив фильтров
    var filters: [Category] { get set }

    // Метод для получения задач с бэкенда
    func fetchTasks(completion: @escaping (Result<[Goal], Error>) -> Void)

    // Метод для получения фильтров с бэкенда
    func fetchFilters(completion: @escaping (Result<[Category], Error>) -> Void)
    
    func createGoal(goalRequest: GoalRequest, completion: @escaping (Result<String, Error>) -> Void)
    
    func createFilter(newFilter: UpdateFilterRequest, completion: @escaping (Result<String, Error>) -> Void)
    func updateFilter(id: String, updateRequest: UpdateFilterRequest, completion: @escaping (Result<String, Error>) -> Void)
    func deleteFilter(id: String, completion: @escaping (Result<String, Error>) -> Void)
    
    func getGoalUsingAI(request: AiGoalRequest, completion: @escaping (Result<GoalPlan, Error>) -> Void)
    func updateGoal(id: String, goalRequest: GoalRequest, completion: @escaping (Result<String, Error>) -> Void)
    
}
