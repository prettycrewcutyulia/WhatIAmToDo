//
//  FiltersBottomSheetView.swift
//  WhatIAmToDo
//
//  Created by Юлия Гудошникова on 16.03.2025.
//

import SwiftUI

struct FiltersBottomSheetSelectedView: View {
    
    @Binding var selectedCategory: Set<Category>
    var filters: [Category]
    @Binding var isPresented: Bool

    var body: some View {
        VStack(alignment: .leading, spacing: 17) {
            HStack {
                Text("Filters")
                    .font(.targetFont(size: 20.3))
                    .fontWeight(.heavy)
                    .fontDesign(.rounded)
                Spacer()
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
                        
                        if selectedCategory.contains(filter) {
                            Image(systemName: "checkmark")
                                .resizable()
                                .frame(width: 18, height: 18)
                                .padding(.horizontal, 14)
                        }
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .frame(height: 49)
                    .background(.white)
                    .cornerRadius(12)
                    .onTapGesture {
                        if selectedCategory.contains(filter) {
                            selectedCategory.remove(filter)
                        } else {
                            selectedCategory.insert(filter)
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
}

private enum Constants {
    static let defaultColor: Color =
    Color(.sRGB, red: 0.98, green: 0.9, blue: 0.2)
}
