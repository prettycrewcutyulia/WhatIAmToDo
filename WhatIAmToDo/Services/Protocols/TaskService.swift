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
        
    // Метод для отправки задач на бэкенд
    func sendTasks(_ tasks: [Goal], completion: @escaping (Result<Void, Error>) -> Void)

    // Метод для отправки фильтров на бэкенд
    func sendFilters(_ filters: [Category], completion: @escaping (Result<Void, Error>) -> Void)
}
