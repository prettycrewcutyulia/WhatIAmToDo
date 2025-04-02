//
//  NetworkError.swift
//  WhatIAmToDo
//
//  Created by Юлия Гудошникова on 22.03.2025.
//


enum NetworkError: Error {
    case invalidResponse
    case noData
    case decodingError
    case unauthorized
    case unknownStatus(Int)
}