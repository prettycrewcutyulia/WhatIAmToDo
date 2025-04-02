//
//  LoginResponse.swift
//  WhatIAmToDo
//
//  Created by Юлия Гудошникова on 22.03.2025.
//


struct LoginResponse: Codable {

    let id: Int
    let name: String
    let email: String
    let token: String
}
