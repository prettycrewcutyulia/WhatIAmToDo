//
//  AllTasksView.swift
//  WhatIAmToDo
//
//  Created by Юлия Гудошникова on 04.01.2025.
//

import SwiftUI

struct AllTasksView: View {
    
    @ObservedObject var viewModel = AllTaskViewModel()

    var body: some View {
        ZStack(alignment: .bottomTrailing) {
            VStack(alignment: .leading) {
                    title
                SearchBarView(
                    text: $viewModel.queryString,
                    selectedCategory: $viewModel.selectedCategory,
                    selectedCategoryColor: $viewModel.selectedCategoryColor,
                    filters: $viewModel.filters
                )
                    ScrollView {
                        LazyVGrid(columns: [
                            GridItem(.flexible(), spacing: 22),
                            GridItem(.flexible(), spacing: 22)
                        ], spacing: 22) {
                            ForEach(viewModel.filteredTasks) { task in
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
