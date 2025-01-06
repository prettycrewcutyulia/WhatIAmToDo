//
//  AllTasksView.swift
//  WhatIAmToDo
//
//  Created by Юлия Гудошникова on 04.01.2025.
//

import SwiftUI

struct AllTasksView: View {
    var body: some View {
        VStack {
            Text("Tasks")
                .font(.targetFont(size: 20.3))
                .fontWeight(.heavy)
                .fontDesign(.rounded)
                .foregroundStyle(Color.accentColor)
            HStack {
                Image("Filters")
                    .background {
                        RoundedRectangle(cornerRadius: 12)
                            .fill(.accent)
                            .frame(width: 49, height: 49)
                    }
                    .onTapGesture {
                        print("Filters tapped")
                    }
            }
        }
    }
}

#Preview {
    AllTasksView()
}
