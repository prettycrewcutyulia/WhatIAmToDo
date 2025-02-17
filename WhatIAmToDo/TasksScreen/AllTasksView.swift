////
////  AllTasksView.swift
////  WhatIAmToDo
////
////  Created by Юлия Гудошникова on 04.01.2025.
////
//
//import SwiftUI
//
//struct AllTasksView: View {
//    @State private var queryString = ""
//
//    var body: some View {
//        VStack {
//            Text("Tasks")
//                .font(.targetFont(size: 20.3))
//                .fontWeight(.heavy)
//                .fontDesign(.rounded)
//                .foregroundStyle(Color.accentColor)
//                NavigationStack {
//                    HStack {
//                        Image("Filters")
//                            .background {
//                                RoundedRectangle(cornerRadius: 12)
//                                    .fill(.accent)
//                                    .frame(width: 49, height: 49)
//                            }
//                            .onTapGesture {
////                                print("Filters tapped")
//                            }
//                    }
//                }
//                .searchable(text: $queryString, prompt: "Find your task")
//            
//                .frame(width: 245)
//                .tint(Color.accentColor)
//        }
//    }
//}
//
#Preview {
    AllTasksView()
}


import SwiftUI

struct Goal: Identifiable {
    var id = UUID()
    var name: String
    var category: String
}

struct AllTasksView: View {
    @State private var queryString = ""
    @State private var selectedCategory: String = "All"

    // Пример данных
    let tasks = [
        Goal(name: "Buy groceries", category: "Personal"),
        Goal(name: "Complete project", category: "Work"),
        Goal(name: "Gym session", category: "Personal"),
        Goal(name: "Team meeting", category: "Work")
    ]

    // Доступные категории
    let categories = ["All", "Work", "Personal"]

    var filteredTasks: [Goal] {
        tasks.filter { task in
            (selectedCategory == "All" || task.category == selectedCategory) &&
            (queryString.isEmpty || task.name.lowercased().contains(queryString.lowercased()))
        }
    }

    var body: some View {
        NavigationView {
            VStack {
                // Список задач
                List(filteredTasks) { task in
                    Text(task.name)
                }
                .background(Color.background)
                .tint(Color.accentColor)
            }
            .background(Color.background)
            .tint(Color.accentColor)
            .searchable(text: $queryString, prompt: "Find your task")
//            .navigationTitle("Tasks")
//            .navigationBarItems(trailing:  Image("Filters")
//                .background {
//                    RoundedRectangle(cornerRadius: 12)
//                        .fill(.accent)
//                        .frame(width: 49, height: 49)
//                }
//                .onTapGesture {                             print("Filters tapped")
//                }
//            )
            .toolbar {
                        ToolbarItem(placement: .principal) {
                            HStack {
                                Image(systemName: "sun.min.fill")
                                Text("Title").font(.title)
                            }
                        }
                        
                    }
            .background(Color.background)
            .tint(Color.accentColor)
        }
    }
}

//struct AllTasksView_Previews: PreviewProvider {
//    static var previews: some View {
//        AllTasksView()
//    }
//}
