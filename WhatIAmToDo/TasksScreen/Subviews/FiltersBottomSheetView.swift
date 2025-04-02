//
//  FiltersBottomSheetView.swift
//  WhatIAmToDo
//
//  Created by Юлия Гудошникова on 25.02.2025.
//
import SwiftUI

struct FiltersBottomSheetView: View {
    
    @Binding var selectedCategory: Int?
    @Binding var selectedColor: Color
    @Binding var filters: [Category]
    @Binding var isPresented: Bool

    @State private var isEditing: Bool = false
    @State private var editingFilterIndex: Int? = nil
    @State private var filterName: String = ""
    @State private var filterColor: Color = Constants.defaultColor
    
    private let taskService: TaskService = DIContainer.shared.resolve()
    
    var body: some View {
        VStack(alignment: .leading, spacing: 17) {
            HStack {
                Text("Filters")
                    .font(.targetFont(size: 20.3))
                    .fontWeight(.heavy)
                    .fontDesign(.rounded)
                Spacer()
                Image(systemName: isEditing ? "xmark" : "square.and.pencil")
                    .resizable()
                    .frame(width: 25, height: 25)
                    .onTapGesture {
                        withAnimation {
                            isEditing.toggle()
                        }
                    }
                
            }
            
            if isEditing {
                HStack {
                    ColorPicker("", selection: $filterColor)
                        .frame(width: 25, height: 25)
                        .padding(.trailing, 8)
                    TextField("Filter Name", text: $filterName)
                    Button("Save") {
                        withAnimation {
                            isEditing.toggle()
                            if let index = editingFilterIndex {
                                let filterId = filters[index].id
                                filters[index] = Category(id: filterId, title: filterName, colorHex: UIColor(filterColor).toHexString() ?? "")
                                taskService.updateFilter(
                                    updateRequest: UpdateFilterRequest(
                                        id: filterId,
                                        title: filterName,
                                        color: UIColor(filterColor).toHexString() ?? ""
                                    ),
                                    completion: {
                                        res in
                                        switch res {
                                        case let .success(newFilters):
                                            filters = newFilters
                                        case .failure(_):
                                            print("Не удалось сохранить фильтр")
                                        }
                                    }
                                )
                                filterName = ""
                                editingFilterIndex = nil
                                filterColor = Constants.defaultColor
                            } else {
                                taskService.createFilter(newFilter: UpdateFilterRequest(id: nil, title: filterName, color: UIColor(filterColor).toHexString() ?? ""), completion: {
                                    res in
                                    switch res {
                                    case let .success(newFilters):
                                        filters = newFilters
                                    case .failure(_):
                                        print("Не удалось сохранить фильтр")
                                    }
                                })
                                
                            }
                        }
                    }
                }
                .padding()
                .background(.white)
                .cornerRadius(12)
            }
            ScrollView {
                ForEach(Array(filters.enumerated()), id: \.element.id) { index, filter in
                    HStack {
                        filter.color
                            .frame(width: 11, height: 11)
                            .cornerRadius(3)
                            .padding(.horizontal, 14)
                        
                        Text(filter.title)
                            .font(.targetFont(size: 16))
                            .fontDesign(.rounded)
                        Spacer()
                        
                        HStack {
                            Button(action: {
                                print(filter.title)
                                editingFilterIndex = index
                                filterName = filter.title
                                filterColor = filter.color
                                isEditing.toggle()
                            }) {
                                Image(systemName: "pencil")
                            }
                            .buttonStyle(BorderlessButtonStyle())
                            
                            Button(action: {
                                print("delete \(filter.title)")
                                deleteFilter(filter)
                            }) {
                                Image(systemName: "trash")
                            }
                            .buttonStyle(BorderlessButtonStyle())
                        }
                        .padding(.trailing, 14)
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .frame(height: 49)
                    .background(.white)
                    .overlay(
                        RoundedRectangle(cornerRadius: 12)
                            .stroke(
                                filter.id == selectedCategory ? Color.accentColor : Color.clear,
                                lineWidth: filter.id == selectedCategory ? 2 : 0
                            )
                    )
                    .cornerRadius(12)
                    .disabled(index == editingFilterIndex)
                    .onTapGesture {
                        if selectedCategory == filter.id {
                            selectedCategory = nil
                            selectedColor = .background
                        } else {
                            selectedCategory = filter.id
                            selectedColor = filter.color
                            isPresented.toggle()
                        }
                    }
                }
            }
            .frame(maxWidth: .infinity, alignment: .leading)
        }
        .foregroundStyle(Color.accentColor)
        .padding()
        .background(Color.background)
    }
    
    private func deleteFilter(_ filter: Category) {
        if let index = filters.firstIndex(where: { $0.id == filter.id }) {
            filters.remove(at: index)
        }
        
        taskService.deleteFilter(id: filter.id, completion: { _ in })
    }
}

private enum Constants {
    static let defaultColor: Color =
    Color(.sRGB, red: 0.98, green: 0.9, blue: 0.2)
}
