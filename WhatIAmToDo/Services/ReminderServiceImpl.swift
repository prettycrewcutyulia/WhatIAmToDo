//
//  Reminder.swift
//  WhatIAmToDo
//
//  Created by Юлия Гудошникова on 23.04.2025.
//


import Foundation

struct Reminder: Codable {
    let reminderId: Int?
    let userId: Int
    let daysCount: Int
}

struct ReminderServiceImpl {
    private let baseURL = "http://localhost:5112/api/Reminders"
    private var userDefaults: any UserDefaultsService
    
    init(userDefaults: any UserDefaultsService) {
        self.userDefaults = userDefaults
    }

    func getReminders(by userId: Int, completion: @escaping (Result<[Reminder], Error>) -> Void) {
        guard let url = URL(string: "\(baseURL)/\(userId)") else {
            completion(.failure(NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "Invalid URL"])))
            return
        }
        var userData = self.userDefaults.getUserIdAndUserToken()
        
        guard let userData else {
            
            completion(.failure(NSError(domain: "Invalid Response", code: -1, userInfo: nil)))
            return
        }

        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("Bearer \(userData.userToken)", forHTTPHeaderField: "Authorization")

        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }

            guard let data = data else {
                completion(.failure(NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "No data received"])))
                return
            }

            do {
                let reminders = try JSONDecoder().decode([Reminder].self, from: data)
                completion(.success(reminders))
            } catch {
                completion(.failure(error))
            }
        }.resume()
    }

    func addReminder(_ reminder: Reminder, completion: @escaping (Result<Int, Error>) -> Void) {
        guard let url = URL(string: baseURL) else {
            completion(.failure(NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "Invalid URL"])))
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

        do {
            let jsonData = try JSONEncoder().encode(reminder)
            request.httpBody = jsonData
        } catch {
            completion(.failure(error))
            return
        }

        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }

            guard let data = data else {
                completion(.failure(NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "No data received"])))
                return
            }

            do {
                if let reminderId = try JSONSerialization.jsonObject(with: data, options: []) as? Int {
                    completion(.success(reminderId))
                } else {
                    completion(.failure(NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "Unexpected response"])))
                }
            } catch {
                completion(.failure(error))
            }
        }.resume()
    }

    func deleteReminder(by id: Int, completion: @escaping (Result<Void, Error>) -> Void) {
        guard let url = URL(string: "\(baseURL)/\(id)") else {
            completion(.failure(NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "Invalid URL"])))
            return
        }
        
        var userData = self.userDefaults.getUserIdAndUserToken()
        
        guard let userData else {
            
            completion(.failure(NSError(domain: "Invalid Response", code: -1, userInfo: nil)))
            return
        }

        var request = URLRequest(url: url)
        request.httpMethod = "DELETE"
        request.setValue("Bearer \(userData.userToken)", forHTTPHeaderField: "Authorization")

        URLSession.shared.dataTask(with: request) { _, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }

            completion(.success(()))
        }.resume()
    }
}
