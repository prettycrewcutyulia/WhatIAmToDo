//
//  AccountService.swift
//  WhatIAmToDo
//
//  Created by Юлия Гудошникова on 20.04.2025.
//


import Foundation

class AccountServiceImpl: AccountService {

    let baseUrl = "http://localhost:5112/api/Account"
    
    private var userDefaults: any UserDefaultsService
    
    init(userDefaults: any UserDefaultsService) {
        self.userDefaults = userDefaults
    }

    // Method to update account
    func updateAccount(_ request: UpdateAccountRequest, completion: @escaping (Result<Void, Error>) -> Void) {
        guard let url = URL(string: "\(baseUrl)/update") else { return }
        var userData = self.userDefaults.getUserIdAndUserToken()
        
        guard let userData else {
            
            completion(.failure(NSError(domain: "Invalid Response", code: -1, userInfo: nil)))
            return
        }
        performRequest(url: url, method: "PUT", userToken: userData.userToken, body: request, completion: completion)
    }
    
    // Method to delete account
    func deleteAccount(_ request: DeleteAccountRequest, completion: @escaping (Result<Void, Error>) -> Void) {
        guard let url = URL(string: "\(baseUrl)/delete") else { return }
        var userData = self.userDefaults.getUserIdAndUserToken()
        
        guard let userData else {
            
            completion(.failure(NSError(domain: "Invalid Response", code: -1, userInfo: nil)))
            return
        }

        performRequest(url: url, method: "DELETE", userToken: userData.userToken, body: request, completion: completion)
    }

    // Method to check existence of telegram info
    func getTgExist(userId: Int, completion: @escaping (Result<Void, Error>) -> Void) {
        guard let url = URL(string: "\(baseUrl)/tgExist/\(userId)") else { return }
        var userData = self.userDefaults.getUserIdAndUserToken()
        
        guard let userData else {
            
            completion(.failure(NSError(domain: "Invalid Response", code: -1, userInfo: nil)))
            return
        }

        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("Bearer \(userData.userToken)", forHTTPHeaderField: "Authorization")

        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }

            guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
                completion(.failure(NSError(domain: "Invalid response", code: 0, userInfo: nil)))
                return
            }

            completion(.success(()))
        }

        task.resume()
    }
    
    // Helper method to perform requests
    private func performRequest<T: Encodable>(url: URL, method: String, userToken: String, body: T, completion: @escaping (Result<Void, Error>) -> Void) {
        var request = URLRequest(url: url)
        request.httpMethod = method
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("Bearer \(userToken)", forHTTPHeaderField: "Authorization")
        
        do {
            let jsonData = try JSONEncoder().encode(body)
            request.httpBody = jsonData
        } catch {
            completion(.failure(error))
            return
        }
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }

            guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
                completion(.failure(NSError(domain: "Invalid response", code: 0, userInfo: nil)))
                return
            }

            completion(.success(()))
        }
        
        task.resume()
    }
}
