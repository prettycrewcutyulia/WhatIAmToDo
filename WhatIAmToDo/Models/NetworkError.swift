//
//  NetworkError.swift
//  WhatIAmToDo
//
//  Created by Юлия Гудошникова on 22.03.2025.
//

enum NetworkError: Error {
    case clientError  // Обобщённые клиентские ошибки (включая невалидный URL, кодирование и пр.)
    case serverError  // Обобщённые серверные ошибки (HTTP 5xx)
}
