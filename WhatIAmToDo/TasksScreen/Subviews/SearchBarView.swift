//
//  SearchBarView.swift
//  WhatIAmToDo
//
//  Created by Юлия Гудошникова on 24.02.2025.
//
import SwiftUI

struct SearchBarView: View {
    @Binding var text: String
    @State private var isEditing = false
    @State private var isBottomSheetPresented = false
    
    var body: some View {
        HStack(spacing: 0) {
            Button(action: {
                print("filters")
                isBottomSheetPresented.toggle()
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
            .sheet(isPresented: $isBottomSheetPresented) {
                // Ваш контент для Bottom Sheet
                FiltersBottomSheetView()
                    .cornerRadius(55)
                    .background(Color.background)
                    .ignoresSafeArea()
                    .presentationDetents([.medium, .large])
            }
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
