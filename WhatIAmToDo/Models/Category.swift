//
//  Category.swift
//  WhatIAmToDo
//
//  Created by Юлия Гудошникова on 24.02.2025.
//

import SwiftUI

struct Category: Identifiable, Hashable, Decodable {
    var id: Int
    var title: String
    var colorHex: String
    
    var color: Color {
        Color(hex: colorHex) ?? .black
    }
    
    // Кастомный инициализатор для Decodable
    private enum CodingKeys: String, CodingKey {
        case id = "filterId"
        case title
        case colorHex = "color" // Здесь мы указываем, что colorHex декодируется из поля "color"
    }
}



import UIKit

extension Color {
    /// Инициализирует Color из строки в шестнадцатеричном формате.
    /// Поддерживает строки в формате "#RRGGBB" и "#RRGGBBAA".
    init?(hex: String) {
        guard let uiColor = UIColor(hex: hex) else { return nil }
        self.init(uiColor)
    }
}

extension UIColor {
    /// Инициализирует UIColor из строки в шестнадцатеричном формате.
    /// Поддерживает строки в формате "#RRGGBB" и "#RRGGBBAA".
    convenience init?(hex: String) {
        var hexSanitized = hex.trimmingCharacters(in: .whitespacesAndNewlines)
        hexSanitized = hexSanitized.hasPrefix("#") ? String(hexSanitized.dropFirst()) : hexSanitized
        
        var rgb: UInt64 = 0
        guard Scanner(string: hexSanitized).scanHexInt64(&rgb) else { return nil }
        
        let length = hexSanitized.count
        var r, g, b, a: UInt64
        switch length {
        case 6: // #RRGGBB
            (r, g, b, a) = (rgb >> 16 & 0xFF, rgb >> 8 & 0xFF, rgb & 0xFF, 0xFF)
        case 8: // #RRGGBBAA
            (r, g, b, a) = (rgb >> 24 & 0xFF, rgb >> 16 & 0xFF, rgb >> 8 & 0xFF, rgb & 0xFF)
        default:
            return nil
        }
        
        self.init(
            red: CGFloat(r) / 255.0,
            green: CGFloat(g) / 255.0,
            blue: CGFloat(b) / 255.0,
            alpha: CGFloat(a) / 255.0
        )
    }
    
    func toHexString() -> String? {
        var red: CGFloat = 0
        var green: CGFloat = 0
        var blue: CGFloat = 0
        var alpha: CGFloat = 0
        
        guard self.getRed(&red, green: &green, blue: &blue, alpha: &alpha) else {
            // Поддержка только RGB цветов
            return nil
        }
        
        return String(format: "#%02X%02X%02X%02X",
                      Int(red * 255),
                      Int(green * 255),
                      Int(blue * 255),
                      Int(alpha * 255))
    }
}
