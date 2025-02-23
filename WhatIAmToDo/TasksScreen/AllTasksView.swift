//
//  AllTasksView.swift
//  WhatIAmToDo
//
//  Created by Юлия Гудошникова on 04.01.2025.
//

import SwiftUI

struct Goal: Identifiable {
    var id = UUID()
    var name: String
    var category: [Category]
}

struct Category: Identifiable {
    var id = UUID()
    var name: String
    var color: Color
}

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

struct TaskItemView: View {
    
    var goal: Goal
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Spacer()
                ForEach(goal.category) { category in
                    category.color
                        .frame(width: 11, height: 11)
                        .cornerRadius(3)
                }
            }
            
            Text(goal.name)
                .font(.targetFont(size: 16))
                .fontWeight(.heavy)
                .fontDesign(.rounded)
                .foregroundStyle(Color.accentColor)
            Spacer()
        }
        .padding(15)
        .frame(width: 147, height: 142)
        .background(Color.white)
        .cornerRadius(12)
    }
}

struct SearchBarView: View {
    @Binding var text: String
    @State private var isEditing = false

    var body: some View {
        HStack(spacing: 0) {
            Button(action: {
                print("filters")
            }) {
                HStack {
                    Image("Filters")
                        .resizable()
                        .frame(width: 25, height: 25)
                        .foregroundStyle(Color.black)
                }
                .frame(width: 55, height: 55)
                .background(Color.accentColor)
                .cornerRadius(12)
            }
            .padding(.trailing, 16)
            HStack(spacing: 0) {
                TextField("Find your task", text: $text, onEditingChanged: { editing in
                    self.isEditing = editing
                })
                .padding(.leading, 8)
                .frame(height: 55)
                .background(Color(.white))
                .cornerRadius(12)
                .overlay(
                    HStack {
                        Spacer()
                        
                        if isEditing && !text.isEmpty {
                            Button(action: {
                                self.text = ""
                            }) {
                                Image(systemName: "multiply.circle.fill")
                                    .foregroundColor(.gray)
                                    .padding(.trailing, 8)
                            }
                            .padding(.horizontal, 10)
                        }
                    }
                )
                HStack {
                    Image(systemName: "magnifyingglass")
                        .resizable()
                        .frame(width: 25, height: 25)
                        .foregroundStyle(Color.background)
                }
                .frame(width: 55, height: 55)
                .background(Color.accentColor)
                .cornerRadius(12)
            }
            .background(.white)
            .cornerRadius(12)
        }
    }
}

struct AddButton: View {
    @State private var isPlusTapped = false
    @State private var showExtraButtons = false

    var body: some View {
        VStack(spacing: 14) {
            if showExtraButtons {
                    Button(action: {
                        print("Extra button 1 tapped")
                    }) {
                        Text("AI")
                            .font(.targetFont(size: 20))
                            .fontWeight(.bold)
                            .fontDesign(.rounded)
                            .frame(width: 25, height: 25)
                            .foregroundStyle(.accent)
                            .frame(width: 55, height: 55)
                            .background(Color.white)
                            .cornerRadius(12)
                    }
                    
                    Button(action: {
                        print("Extra button 2 tapped")
                    }) {
                        Image(systemName: "plus")
                            .resizable()
                            .frame(width: 25, height: 25)
                            .foregroundStyle(.accent)
                            .frame(width: 55, height: 55)
                            .background(Color.white)
                            .cornerRadius(12)
                    }
            }
            
            Button(action: {
                isPlusTapped.toggle()
                showExtraButtons.toggle()
            }) {
                HStack {
                    Image(systemName: isPlusTapped ? "xmark" : "plus")
                        .resizable()
                        .frame(width: 25, height: 25)
                        .foregroundStyle(.accent)
                }
                .frame(width: 55, height: 55)
                .background(Color.white)
                .cornerRadius(12)
            }
        }
    }
}
