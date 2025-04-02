//
//  TaskServiceImpl.swift
//  WhatIAmToDo
//
//  Created by Юлия Гудошникова on 25.02.2025.
//
import Foundation

class TaskServiceImpl: TaskService {

    @Published var tasks: [Goal] = []
    var filters: [Category] = []
    
    private var userDefaults: any UserDefaultsService
    
    init(userDefaults: any UserDefaultsService) {
        self.userDefaults = userDefaults
    }
    
    func fetchTasks(completion: @escaping (Result<[Goal], Error>) -> Void) {
        
        self.tasks = []
        // Пример асинхронной загрузки задач
        // Здесь вы можете реализовать сетевой запрос для загрузки задач с бэкенда
        DispatchQueue.global().async {
            // Создаем URL с добавлением параметра userId
            guard var urlComponents = URLComponents(string: "http://localhost:5112/api/Goals") else {
                completion(.failure(NSError(domain: "Invalid URL", code: -1, userInfo: nil)))
                return
            }
            
            var userData = self.userDefaults.getUserIdAndUserToken()
            
            guard let userData else {
                
                completion(.failure(NSError(domain: "Invalid Response", code: -1, userInfo: nil)))
                return
            }
            
            // Добавление параметра userId в URL
            urlComponents.queryItems = [URLQueryItem(name: "userId", value: "\(userData.userId)")]
            
            // Проверяем, что url был успешно сформирован
            guard let url = urlComponents.url else {
                completion(.failure(NetworkError.invalidResponse))
                return
            }
            
            // Конфигурируем запрос
            var request = URLRequest(url: url)
            request.httpMethod = "GET"
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            request.setValue("Bearer \(userData.userToken)", forHTTPHeaderField: "Authorization")

            
            let task = URLSession.shared.dataTask(with: request) { data, response, error in
                if let error = error {
                    completion(.failure(error))
                    return
                }
                
                guard let data = data else {
                    completion(.failure(NSError(domain: "No data received", code: -1, userInfo: nil)))
                    return
                }
                
                do {
                    let decoder = JSONDecoder()
                    
                    // Создаем ISO8601DateFormatter с поддержкой миллисекунд
//                    let formatter = ISO8601DateFormatter()
//                    formatter.formatOptions = [.withInternetDateTime]
                    let dateFormatter = DateFormatter()
                    dateFormatter.locale = Locale(identifier: "en_US_POSIX")
                    dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
                    
                    // Настройка DateDecodingStrategy с использованием custom стратегии
                    decoder.dateDecodingStrategy = .custom { decoder in
                        let dateString = try decoder.singleValueContainer().decode(String.self)
                        if let date = dateFormatter.date(from: dateString) {
                            return date
                        } else {
                            throw DecodingError.dataCorruptedError(in: try decoder.singleValueContainer(), debugDescription: "Invalid date format.")
                        }
                    }
                    // Декодируем полученные данные в массив объектов Goal
                    let goals = try decoder.decode([Goal].self, from: data)
                    self.tasks = goals
                    completion(.success(goals))
                } catch {
                    completion(.failure(error))
                }
            }
            
            task.resume()
        }
    }
    
    func fetchFilters(completion: @escaping (Result<[Category], Error>) -> Void) {
        self.filters = []
        // Пример асинхронной загрузки фильтров
        // Здесь вы можете реализовать сетевой запрос для загрузки фильтров с бэкенда
        DispatchQueue.global().async {
            guard var urlComponents = URLComponents(string: "http://localhost:5112/api/Filters") else {
                completion(.failure(NSError(domain: "Invalid URL", code: -1, userInfo: nil)))
                return
            }
            
            var userData = self.userDefaults.getUserIdAndUserToken()
            
            guard let userData else {
                
                completion(.failure(NSError(domain: "Invalid Response", code: -1, userInfo: nil)))
                return
            }
            
            // Добавление параметра userId в URL
            urlComponents.queryItems = [URLQueryItem(name: "userId", value: "\(userData.userId)")]
        
            
            // Проверяем, что url был успешно сформирован
            guard let url = urlComponents.url else {
                completion(.failure(NSError(domain: "Invalid URL with query", code: -1, userInfo: nil)))
                return
            }
            
            // Конфигурируем запрос
            var request = URLRequest(url: url)
            request.httpMethod = "GET"
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            request.setValue("Bearer \(userData.userToken)", forHTTPHeaderField: "Authorization")
            
            let task = URLSession.shared.dataTask(with: url) { data, response, error in
                if let error = error {
                    completion(.failure(error))
                    return
                }
                
                guard let data = data else {
                    completion(.failure(NSError(domain: "No data received", code: -1, userInfo: nil)))
                    return
                }
                
                do {
                    let decoder = JSONDecoder()
                    
                    // Декодируем полученные данные в массив объектов Goal
                    let category = try decoder.decode([Category].self, from: data)
                    self.filters = category
                    completion(.success(category))
                } catch {
                    completion(.failure(error))
                }
            }
            
            task.resume()
        }
    }
    
    // Функция отправки POST-запроса
    func createGoal(goalRequest: GoalRequest, completion: @escaping (Result<String, Error>) -> Void) {
        // URL эндпоинта
        let urlString = "http://localhost:5112/api/Goals/create" // Замените на ваш реальный URL
        guard let url = URL(string: urlString) else {
            completion(.failure(NSError(domain: "Invalid URL", code: 1, userInfo: nil)))
            return
        }
        
        var userData = self.userDefaults.getUserIdAndUserToken()
        
        guard let userData else {
            
            completion(.failure(NSError(domain: "Invalid Response", code: -1, userInfo: nil)))
            return
        }
        
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("Bearer \(userData.userToken)", forHTTPHeaderField: "Authorization")
        
        // Конфигурация JSONEncoder для дат
        let encoder = JSONEncoder()
        encoder.dateEncodingStrategy = .iso8601
        
        do {
            let jsonData = try encoder.encode(goalRequest)
            request.httpBody = jsonData
            
            // Отправка запроса с использованием URLSession
            let task = URLSession.shared.dataTask(with: request) { data, response, error in
                if let error = error {
                    completion(.failure(error))
                    return
                }
                
                // Обработка ответа
                if let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 {
                    if let data = data, let message = String(data: data, encoding: .utf8) {
                        self.fetchTasks(completion: {res in
                            switch res {
                            case .success(_):
                                completion(.success(message))
                            case .failure(let error):
                                completion(.failure(error))
                            }
                        })
                    } else {
                        completion(.failure(NSError(domain: "Invalid response data", code: 2, userInfo: nil)))
                    }
                } else {
                    completion(.failure(NSError(domain: "Invalid response", code: 3, userInfo: nil)))
                }
            }
            
            task.resume()
        } catch {
            completion(.failure(error))
        }
    }
    
    // Функция для отправки запроса
    func createFilter(newFilter: UpdateFilterRequest, completion: @escaping (Result<[Category], Error>) -> Void) {
        var userData = self.userDefaults.getUserIdAndUserToken()
        
        guard let userData else {
            
            completion(.failure(NSError(domain: "Invalid Response", code: -1, userInfo: nil)))
            return
        }
        
        // URL эндпоинта
        let baseURL = "http://localhost:5112/api/Filters/create?userId=\(userData.userId)" // Замените на реальный URL вашего API
        
        guard let url = URL(string: baseURL) else {
            completion(.failure(NSError(domain: "Invalid URL", code: 1, userInfo: nil)))
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("Bearer \(userData.userToken)", forHTTPHeaderField: "Authorization")
        
        // Сериализация объекта newFilter в JSON
        let encoder = JSONEncoder()
        
        do {
            let jsonData = try encoder.encode(newFilter)
            request.httpBody = jsonData
            
            // Отправка запроса с использованием URLSession
            let task = URLSession.shared.dataTask(with: request) { data, response, error in
                if let error = error {
                    completion(.failure(error))
                    return
                }
                
                // Обработка ответа
                if let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 {
                    if let data = data, let message = String(data: data, encoding: .utf8) {
                        self.fetchFilters(completion: { res in
                            completion(res)
                        })
                    } else {
                        completion(.failure(NSError(domain: "Invalid response data", code: 2, userInfo: nil)))
                    }
                } else {
                    completion(.failure(NSError(domain: "Invalid response", code: 3, userInfo: nil)))
                }
            }
            
            task.resume()
        } catch {
            completion(.failure(error))
        }
    }
    
    // Функция для обновления фильтра
    func updateFilter(
        updateRequest: UpdateFilterRequest,
        completion: @escaping (Result<[Category], Error>) -> Void
    ) {
        // URL эндпоинта для обновления
        let baseURL = "http://localhost:5112/api/Filters/update" // Замените на реальный URL вашего API
        
        guard let url = URL(string: baseURL) else {
            completion(.failure(NSError(domain: "Invalid URL", code: 1, userInfo: nil)))
            return
        }
        
        var userData = self.userDefaults.getUserIdAndUserToken()
        
        guard let userData else {
            
            completion(.failure(NSError(domain: "Invalid Response", code: -1, userInfo: nil)))
            return
        }
    
        var request = URLRequest(url: url)
        request.httpMethod = "PUT"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("Bearer \(userData.userToken)", forHTTPHeaderField: "Authorization")
        
        let encoder = JSONEncoder()
        
        do {
            let jsonData = try encoder.encode(updateRequest)
            request.httpBody = jsonData
            
            // Отправка запроса
            let task = URLSession.shared.dataTask(with: request) { data, response, error in
                if let error = error {
                    completion(.failure(error))
                    return
                }
                
                if let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 {
                    if let data = data, let message = String(data: data, encoding: .utf8) {
                        self.fetchFilters(completion: { res in
                            completion(res)
                        })
                    } else {
                        completion(.failure(NSError(domain: "Invalid response data", code: 2, userInfo: nil)))
                    }
                } else {
                    completion(.failure(NSError(domain: "Invalid response", code: 3, userInfo: nil)))
                }
            }
            
            task.resume()
        } catch {
            completion(.failure(error))
        }
        
        fetchFilters(completion: { _ in })
    }
    
    // Функция для удаления фильтра
    func deleteFilter(id: Int, completion: @escaping (Result<String, Error>) -> Void) {
        // URL эндпоинта для удаления
        let baseURL = "http://localhost:5112/api/Filters/delete?id=\(id)"
        
        guard let url = URL(string: baseURL) else {
            completion(.failure(NSError(domain: "Invalid URL", code: 1, userInfo: nil)))
            return
        }
        
        var userData = self.userDefaults.getUserIdAndUserToken()
        
        guard let userData else {
            
            completion(.failure(NSError(domain: "Invalid Response", code: -1, userInfo: nil)))
            return
        }

        var request = URLRequest(url: url)
        request.httpMethod = "DELETE"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("Bearer \(userData.userToken)", forHTTPHeaderField: "Authorization")
        
        // Отправка запроса
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            if let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 {
                if let data = data, let message = String(data: data, encoding: .utf8) {
                    completion(.success(message))
                } else {
                    completion(.failure(NSError(domain: "Invalid response data", code: 2, userInfo: nil)))
                }
            } else {
                completion(.failure(NSError(domain: "Invalid response", code: 3, userInfo: nil)))
            }
        }
        
        task.resume()
        
        fetchFilters(completion: { _ in })
    }
    
    // Функция для отправки запроса и обработки ответа
    func getGoalUsingAI(request: AiGoalRequest, completion: @escaping (Result<GoalPlan, Error>) -> Void) {
        // URL эндпоинта
        let baseURL = "http://localhost:5112/api/Goals/get-ai" // Замените на реальный URL вашего API
        
        guard let url = URL(string: baseURL) else {
            completion(.failure(NSError(domain: "Invalid URL", code: 1, userInfo: nil)))
            return
        }
        
        var userData = self.userDefaults.getUserIdAndUserToken()
        
        guard let userData else {
            
            completion(.failure(NSError(domain: "Invalid Response", code: -1, userInfo: nil)))
            return
        }
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "POST"
        urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
        urlRequest.setValue("Bearer \(userData.userToken)", forHTTPHeaderField: "Authorization")
        
        let encoder = JSONEncoder()
        
        do {
            let jsonData = try encoder.encode(request)
            urlRequest.httpBody = jsonData
            
            // Отправка запроса с использованием URLSession
            let task = URLSession.shared.dataTask(with: urlRequest) { data, response, error in
                if let error = error {
                    completion(.failure(error))
                    return
                }
                
                // Обработка ответа
                if let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 {
                    guard let data = data else {
                        completion(.failure(NSError(domain: "No data returned", code: 4, userInfo: nil)))
                        return
                    }
                    
                    do {
                        let decoder = JSONDecoder()
                        let goalPlan = try decoder.decode(GoalPlan.self, from: data)
                        completion(.success(goalPlan))
                    } catch {
                        completion(.failure(error))
                    }
                } else {
                    completion(.failure(NSError(domain: "Invalid response", code: 3, userInfo: nil)))
                }
            }
            
            task.resume()
        } catch {
            completion(.failure(error))
        }
        
        fetchTasks(completion: {_ in})
    }
    
    // Функция для отправки PUT-запроса на обновление цели
    func updateGoal(id: Int, goalRequest: GoalRequest, completion: @escaping (Result<String, Error>) -> Void) {
        // URL эндпоинта
        let baseURL = "http://localhost:5112/api/Goals/update/\(id)" // Замените на реальный URL вашего API
        
        guard let url = URL(string: baseURL) else {
            completion(.failure(NSError(domain: "Invalid URL", code: 1, userInfo: nil)))
            return
        }
        
        var userData = self.userDefaults.getUserIdAndUserToken()
        
        guard let userData else {
            
            completion(.failure(NSError(domain: "Invalid Response", code: -1, userInfo: nil)))
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "PUT"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("Bearer \(userData.userToken)", forHTTPHeaderField: "Authorization")
        
        // Сериализация объекта GoalRequest в JSON
        let encoder = JSONEncoder()
        encoder.dateEncodingStrategy = .iso8601
        
        do {
            do {
                let jsonData = try encoder.encode(goalRequest)
                request.httpBody = jsonData
            } catch {
                print("Ошибка сериализации JSON: \(error.localizedDescription)")
                completion(.failure(error))
                return
            }
            
            // Отправка запроса с использованием URLSession
            let task = URLSession.shared.dataTask(with: request) { data, response, error in
                if let error = error {
                    completion(.failure(error))
                    return
                }
                
                // Обработка ответа
                if let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 {
                    self.fetchTasks(completion: { res in
                        switch res {
                        case .success(_):
                            completion(.success("success"))
                        case .failure(let error):
                            completion(.failure(error))
                        }
                    })
                } else {
                    completion(.failure(NSError(domain: "Invalid response", code: 3, userInfo: nil)))
                }
            }
            
            task.resume()
        } catch {
            completion(.failure(error))
        }
        
    }
    
    func deleteGoalById(id: Int, completion: @escaping (Result<String, Error>) -> Void) {
        // URL эндпоинта для удаления
        let baseURL = "http://localhost:5112/api/Goals/delete?id=\(id)"
        
        guard let url = URL(string: baseURL) else {
            completion(.failure(NSError(domain: "Invalid URL", code: 1, userInfo: nil)))
            return
        }
        
        var userData = self.userDefaults.getUserIdAndUserToken()
        
        guard let userData else {
            
            completion(.failure(NSError(domain: "Invalid Response", code: -1, userInfo: nil)))
            return
        }

        var request = URLRequest(url: url)
        request.httpMethod = "DELETE"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("Bearer \(userData.userToken)", forHTTPHeaderField: "Authorization")
        
        // Отправка запроса
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            if let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 {
                if let data = data, let message = String(data: data, encoding: .utf8) {
                    completion(.success(message))
                } else {
                    completion(.failure(NSError(domain: "Invalid response data", code: 2, userInfo: nil)))
                }
            } else {
                completion(.failure(NSError(domain: "Invalid response", code: 3, userInfo: nil)))
            }
        }
        
        task.resume()
        
        fetchFilters(completion: { _ in })
    }
}

// Реализация метода конвертации строки в дату
func dateFromString(_ dateString: String) -> Date? {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "yyyy-MM-dd"
    return dateFormatter.date(from: dateString)
}
