//
//  AuthorizationServiceImpl.swift
//  WhatIAmToDo
//
//  Created by Юлия Гудошникова on 22.03.2025.
//

import Foundation

class AuthorizationServiceImpl: AuthorizationService {
    
    func login(model: AuthRequest, completion: @escaping (Result<LoginResponse, Error>) -> Void) {
        // URL вашего сервера
        // URL вашего сервера
            guard let url = URL(string: "\(Constants.defaultURL)auth/login") else {
                completion(.failure(NetworkError.invalidResponse))
                return
            }

            // Конфигурируем запрос
            var request = URLRequest(url: url)
            request.httpMethod = "POST"
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")

            // Кодируем данные запроса в JSON
            do {
                let jsonBody = try JSONEncoder().encode(model)
                request.httpBody = jsonBody
            } catch {
                completion(.failure(error))
                return
            }

            // Создаём задачу URLSession
            let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let data = data else {
                completion(.failure(NetworkError.noData))
                return
            }
            
            // Обработка ответа сервера
            if let httpResponse = response as? HTTPURLResponse {
                switch httpResponse.statusCode {
                case 200:
                    // Обработка успешного входа
                    do {
                        let loginResponse = try JSONDecoder().decode(LoginResponse.self, from: data)
                        completion(.success(loginResponse))
                    } catch {
                        completion(.failure(NetworkError.decodingError))
                    }
                case 401:
                    completion(.failure(NetworkError.unauthorized))
                default:
                    completion(.failure(NetworkError.unknownStatus(httpResponse.statusCode)))
                }
            } else {
                completion(.failure(NetworkError.invalidResponse))
            }
        }
            
            // Запуск задачи
        task.resume()
    }
    
    
    // Метод для получения задач с бэкенда
    func registration(model: RegistrationRequest, completion: @escaping (Result<LoginResponse, Error>) -> Void) {

            guard let url = URL(string: "\(Constants.defaultURL)Auth/register") else {
                completion(.failure(NetworkError.invalidResponse))
                return
            }

            // Конфигурируем запрос
            var request = URLRequest(url: url)
            request.httpMethod = "POST"
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")

            // Кодируем данные запроса в JSON
            do {
                let jsonBody = try JSONEncoder().encode(model)
                request.httpBody = jsonBody
            } catch {
                completion(.failure(error))
                return
            }

            // Создаём задачу URLSession
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let data = data else {
                completion(.failure(NetworkError.noData))
                return
            }
            
            // Обработка ответа сервера
            if let httpResponse = response as? HTTPURLResponse {
                switch httpResponse.statusCode {
                case 200:
                    // Обработка успешного входа
                    do {
                        let loginResponse = try JSONDecoder().decode(LoginResponse.self, from: data)
                        completion(.success(loginResponse))
                    } catch {
                        completion(.failure(NetworkError.decodingError))
                    }
                case 401:
                    completion(.failure(NetworkError.unauthorized))
                default:
                    completion(.failure(NetworkError.unknownStatus(httpResponse.statusCode)))
                }
            } else {
                completion(.failure(NetworkError.invalidResponse))
            }
        }
            
            // Запуск задачи
        task.resume()
    }
}

private enum Constants {
    static let defaultURL = "http://localhost:5112/api/"
}
