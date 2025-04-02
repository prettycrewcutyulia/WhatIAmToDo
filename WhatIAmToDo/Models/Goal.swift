//
//  Goal.swift
//  WhatIAmToDo
//
//  Created by Юлия Гудошникова on 24.02.2025.
//

import Foundation

struct Goal: Identifiable, Hashable, Decodable {
    var id: Int
    var title: String
    var categoryId: [Int]
    var steps: [Step]
    var startDate: Date?
    var deadline: Date?
    
    var completedSteps : Int {
        steps.filter(\.isCompleted).count
    }
}

struct Step: Identifiable, Hashable, Decodable {
    let id: Int?
    var title: String
    var isCompleted: Bool = false
    var deadline: Date?
}
