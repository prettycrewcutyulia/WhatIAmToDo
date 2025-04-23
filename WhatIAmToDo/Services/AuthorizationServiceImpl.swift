//
//  AuthorizationServiceImpl.swift
//  WhatIAmToDo
//
//  Created by Юлия Гудошникова on 22.03.2025.
//

import Foundation

class AuthorizationServiceImpl: AuthorizationService {
    
    func login(model: AuthRequest, completion: @escaping (Result<LoginResponse, NetworkError>) -> Void) {
        guard let url = URL(string: "\(Constants.defaultURL)auth/login") else {
            completion(.failure(.clientError))
            return
        }

        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")

        do {
            let jsonBody = try JSONEncoder().encode(model)
            request.httpBody = jsonBody
        } catch {
            completion(.failure(.clientError))
            return
        }

        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if error != nil {
                completion(.failure(.clientError))
                return
            }
            
            guard let data = data else {
                completion(.failure(.clientError))
                return
            }
            
            if let httpResponse = response as? HTTPURLResponse {
                switch httpResponse.statusCode {
                case 200:
                    do {
                        let loginResponse = try JSONDecoder().decode(LoginResponse.self, from: data)
                        completion(.success(loginResponse))
                    } catch {
                        completion(.failure(.clientError))
                    }
                case 400...499:
                    completion(.failure(.clientError))
                case 500...599:
                    completion(.failure(.serverError))
                default:
                    completion(.failure(.clientError))
                }
            } else {
                completion(.failure(.clientError))
            }
        }
        
        task.resume()
    }
    
    func registration(model: RegistrationRequest, completion: @escaping (Result<LoginResponse, NetworkError>) -> Void) {
        guard let url = URL(string: "\(Constants.defaultURL)Auth/register") else {
            completion(.failure(.clientError))
            return
        }

        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")

        do {
            let jsonBody = try JSONEncoder().encode(model)
            request.httpBody = jsonBody
        } catch {
            completion(.failure(.clientError))
            return
        }

        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if error != nil {
                completion(.failure(.clientError))
                return
            }
            
            guard let data = data else {
                completion(.failure(.clientError))
                return
            }
            
            if let httpResponse = response as? HTTPURLResponse {
                switch httpResponse.statusCode {
                case 200:
                    do {
                        let loginResponse = try JSONDecoder().decode(LoginResponse.self, from: data)
                        completion(.success(loginResponse))
                    } catch {
                        completion(.failure(.clientError))
                    }
                case 400...499:
                    completion(.failure(.clientError))
                case 500...599:
                    completion(.failure(.serverError))
                default:
                    completion(.failure(.clientError))
                }
            } else {
                completion(.failure(.clientError))
            }
        }
        
        task.resume()
    }
}

private enum Constants {
    static let defaultURL = "http://localhost:5112/api/"
}
