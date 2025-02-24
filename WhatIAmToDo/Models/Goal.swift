//
//  Goal.swift
//  WhatIAmToDo
//
//  Created by Юлия Гудошникова on 24.02.2025.
//

import Foundation

struct Goal: Identifiable {
    var id = UUID()
    var name: String
    var category: [Category]
}
