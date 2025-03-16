//
//  TaskServiceImpl.swift
//  WhatIAmToDo
//
//  Created by Юлия Гудошникова on 25.02.2025.
//
import Foundation

class TaskServiceImpl: TaskService {

    var tasks: [Goal] = []
    var filters: [Category] = []

    func fetchTasks(completion: @escaping (Result<[Goal], Error>) -> Void) {
        
        let tasks = [
            Goal(name: "Buy groceries", category: [Category(id: UUID().uuidString, name: "Personal", color: .blue)], steps: [], startDate: dateFromString("2025-03-14")),
            Goal(name: "Complete project", category: [Category(id: UUID().uuidString, name: "Work", color: .green)], steps: []),
            Goal(name: "Gym session", category: [Category(id: UUID().uuidString, name: "Personal", color: .blue)], steps: []),
            Goal(name: "Team meeting", category: [Category(id: UUID().uuidString, name: "Work", color: .red)], steps: [])
        ]
        
        self.tasks = tasks
        // Пример асинхронной загрузки задач
        // Здесь вы можете реализовать сетевой запрос для загрузки задач с бэкенда
        DispatchQueue.global().async {
            // Ваш код для загрузки задач
            // После загрузки задач вызывайте completion с полученными данными или ошибкой
            
            // Пример успешного выполнения
            completion(.success(self.tasks))
            // Или если произошла ошибка
            // completion(.failure(YourErrorType.someError))
        }
    }

    func fetchFilters(completion: @escaping (Result<[Category], Error>) -> Void) {
        var filters: [Category] = [
            Category(id: UUID().uuidString, name: "Work", color: .green),
            Category(id: UUID().uuidString, name: "Personal", color: .blue),
            Category(id: UUID().uuidString, name: "Work", color: .red)
        ]
        
        self.filters = filters
        // Пример асинхронной загрузки фильтров
        // Здесь вы можете реализовать сетевой запрос для загрузки фильтров с бэкенда
        DispatchQueue.global().async {
            // Ваш код для загрузки фильтров
            
            // Пример успешного выполнения
            completion(.success(self.filters))
            // Или если произошла ошибка
            // completion(.failure(YourErrorType.someError))
        }
    }
    
    func sendTasks(_ tasks: [Goal], completion: @escaping (Result<Void, Error>) -> Void) {
        // Пример асинхронной отправки задач
        // Здесь вы можете реализовать сетевой запрос для отправки задач на бэкенд
        DispatchQueue.global().async {
            // Ваш код для отправки задач
            
            // Пример успешного выполнения
            completion(.success(()))
            // Или если произошла ошибка
            // completion(.failure(YourErrorType.someError))
        }
    }

    func sendFilters(_ filters: [Category], completion: @escaping (Result<Void, Error>) -> Void) {
        // Пример асинхронной отправки фильтров
        // Здесь вы можете реализовать сетевой запрос для отправки фильтров на бэкенд
        DispatchQueue.global().async {
            // Ваш код для отправки фильтров
            
            // Пример успешного выполнения
            completion(.success(()))
            // Или если произошла ошибка
            // completion(.failure(YourErrorType.someError))
        }
    }
}

// Реализация метода конвертации строки в дату
func dateFromString(_ dateString: String) -> Date? {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "yyyy-MM-dd"
    return dateFormatter.date(from: dateString)
}
