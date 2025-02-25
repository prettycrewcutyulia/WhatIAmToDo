//
//  UserDefaultsService.swift
//  WhatIAmToDo
//
//  Created by Юлия Гудошникова on 25.02.2025.
//
import SwiftUI

protocol UserDefaultsService: ObservableObject {
    // Метод для проверки, зарегистрирован ли пользователь
    func isUserRegistered() -> Bool

    // Метод для установки значения регистрации пользователя
    func setUserRegistered(_ isRegistered: Bool) async

    // Метод для получения текущей локали
    func getCurrentLocale() -> String

    // Метод для установки другой локали по предопределенному правилу
    func setAnotherLocale() async

    // Метод для установки конкретной локали на основе переданного значения
    func setAnotherLocale(locale: String) async
}
