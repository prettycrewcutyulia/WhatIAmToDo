//
//  AllTasksView.swift
//  WhatIAmToDo
//
//  Created by Юлия Гудошникова on 04.01.2025.
//

import SwiftUI

struct AllTasksView: View {
    @State private var queryString = ""
    @State private var selectedCategory: String = "All"

    // Пример данных
    let tasks = [
        Goal(name: "Buy groceries", category: [Category(name: "Personal", color: .blue)]),
        Goal(name: "Complete project", category: [Category(name: "Work", color: .green)]),
        Goal(name: "Gym session", category: [Category(name: "Personal", color: .blue)]),
        Goal(name: "Team meeting", category: [Category(name: "Work", color: .red)])
    ]

    // Доступные категории
    let categories = ["All", "Work", "Personal"]

    var filteredTasks: [Goal] {
        tasks.filter { task in
            (selectedCategory == "All" || task.category.contains(where: {$0.name == selectedCategory})) &&
            (queryString.isEmpty || task.name.lowercased().contains(queryString.lowercased()))
        }
    }

    var body: some View {
        ZStack(alignment: .bottomTrailing) {
            VStack(alignment: .leading) {
                    title
                    SearchBarView(text: $queryString)
                    ScrollView {
                        LazyVGrid(columns: [
                            GridItem(.flexible(), spacing: 22),
                            GridItem(.flexible(), spacing: 22)
                        ], spacing: 22) {
                            ForEach(filteredTasks) { task in
                                TaskItemView(goal: task)
                            }
                        }
                    }
                    .padding(.top, 27)
                    .background(Color.background)
                    .tint(Color.accentColor)
                }
                .background(Color.background)
                .tint(Color.accentColor)
            AddButton()
        }
        .padding(25)
        .background(Color.background)
    }
    
    private var title: some View {
        Text("Tasks")
            .font(.targetFont(size: 20.3))
            .fontWeight(.heavy)
            .fontDesign(.rounded)
            .foregroundStyle(Color.accentColor)
    }
}

struct AllTasksView_Previews: PreviewProvider {
    static var previews: some View {
        AllTasksView()
    }
}
