//
//  String+Extension.swift
//  WhatIAmToDo
//
//  Created by Юлия Гудошникова on 19.03.2025.
//


import Foundation

extension String {
    func localized(for localeIdentifier: String, comment: String = "") -> String {
        // Находим путь к файлу .lproj для указанной локализации
        guard let path = Bundle.main.path(forResource: localeIdentifier, ofType: "lproj"),
              let bundle = Bundle(path: path) else {
            return self // Возвращаем оригинальную строку, если локализация не найдена
        }
        
        // Используем созданный бандл для получения локализованной строки
        return NSLocalizedString(self, tableName: nil, bundle: bundle, value: "", comment: comment)
    }
    
    func localizedFormat(for localeIdentifier: String, comment: String = "", _ arguments: CVarArg...) -> String {
        // Получаем локализованную строку
        let localizedString = self.localized(for: localeIdentifier, comment: comment)
        // Форматируем строку с аргументами
        return String(format: localizedString, arguments: arguments)
    }
}
