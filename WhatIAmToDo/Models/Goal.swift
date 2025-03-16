//
//  Goal.swift
//  WhatIAmToDo
//
//  Created by Юлия Гудошникова on 24.02.2025.
//

import Foundation

struct Goal: Identifiable, Hashable {
    var id = UUID()
    var name: String
    var category: [Category]
    var steps: [Step]
    var startDate: Date?
    var deadline: Date?
    
    var completedSteps : Int {
        steps.filter(\.isCompleted).count
    }
}

struct Step: Identifiable, Hashable {
    let id = UUID()
    var title: String
    var isCompleted: Bool = false
}
