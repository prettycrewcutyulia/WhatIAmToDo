//
//  FiltersBottomSheetView.swift
//  WhatIAmToDo
//
//  Created by Юлия Гудошникова on 25.02.2025.
//
import SwiftUI

struct FiltersBottomSheetView: View {
    @State private var isEditing: Bool = false
    @State private var editingFilterIndex: Int? = nil
    @State private var filterName: String = ""
    @State private var filterColor: Color = Constants.defaultColor
    
    @State private var filters: [Category] = [
        Category(name: "Work", color: .green),
        Category(name: "Personal", color: .blue),
        Category(name: "Work", color: .red)
    ]
    
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
                                filters[index] = Category(name: filterName, color: filterColor)
                                filterName = ""
                                editingFilterIndex = nil
                                filterColor = Constants.defaultColor
                            } else {
                                filters.append(Category(name: filterName, color: filterColor))
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
                        
                        Text(filter.name)
                            .font(.targetFont(size: 16))
                            .fontDesign(.rounded)
                        Spacer()
                        
                        HStack {
                            Button(action: {
                                print(filter.name)
                                editingFilterIndex = index
                                filterName = filter.name
                                filterColor = filter.color
                                isEditing.toggle()
                            }) {
                                Image(systemName: "pencil")
                            }
                            .buttonStyle(BorderlessButtonStyle())
                            
                            Button(action: {
                                print("delete \(filter.name)")
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
                    .cornerRadius(12)
                    .disabled(index == editingFilterIndex)
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
    }
}

private enum Constants {
    static let defaultColor: Color =
    Color(.sRGB, red: 0.98, green: 0.9, blue: 0.2)
}
