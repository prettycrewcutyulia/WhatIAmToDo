//
//  AuthorizationService.swift
//  WhatIAmToDo
//
//  Created by Юлия Гудошникова on 22.03.2025.
//

protocol AuthorizationService {
    
    // Метод для получения задач с бэкенда
    func login(model: AuthRequest, completion: @escaping (Result<LoginResponse, NetworkError>) -> Void)
    
    
    // Метод для получения задач с бэкенда
    func registration(model: RegistrationRequest, completion: @escaping (Result<LoginResponse, NetworkError>) -> Void)
}
