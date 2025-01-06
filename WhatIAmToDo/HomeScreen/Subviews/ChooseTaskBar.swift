//
//  ChooseTaskBar.swift
//  WhatIAmToDo
//
//  Created by Юлия Гудошникова on 04.01.2025.
//

import SwiftUI

struct ChooseTaskBar: View {
    var body: some View {
        HStack {
            Text("Choose your task")
                .font(.targetFont(size: 16))
                .fontWeight(.light)
                .foregroundStyle(Color.hint)
            Spacer()
            Image(systemName: "chevron.down")
                .fontWeight(.heavy)
                .tint(Color.accentColor)
        }
        .padding()
        .background(Color.white)
        .cornerRadius(20)
    }
}

#Preview {
    ChooseTaskBar()
}
