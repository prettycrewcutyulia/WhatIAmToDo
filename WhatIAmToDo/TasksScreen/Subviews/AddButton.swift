//
//  AddButton.swift
//  WhatIAmToDo
//
//  Created by Юлия Гудошникова on 24.02.2025.
//
import SwiftUI

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
