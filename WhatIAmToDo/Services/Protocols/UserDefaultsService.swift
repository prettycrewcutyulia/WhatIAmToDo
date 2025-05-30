//
//  UserDefaultsService.swift
//  WhatIAmToDo
//
//  Created by Юлия Гудошникова on 25.02.2025.
//
import SwiftUI

protocol UserDefaultsService: ObservableObject {
    
   var selectedLanguage: String { get set }

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
    
    func setLoginResponseData(response: LoginResponse) async
    
    func getUserIdAndUserToken() -> (userId: Int, userToken: String)?
    func getUserData() -> (name: String, email: String)?
    
    func setImage(_ image: UIImage?)
    func getImage() -> UIImage?
}
