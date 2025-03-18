//
//  TaskStepsView.swift
//  WhatIAmToDo
//
//  Created by Юлия Гудошникова on 07.01.2025.
//

import SwiftUI

struct TaskStepsView: View {
    
    var checkListData: [Step]

    var body: some View {
        VStack(alignment: .leading, spacing: 23) {
            Text("Mark your steps")
                .font(.targetFont(size: 16).width(.expanded))
                .fontWeight(.heavy)
                .fontDesign(.rounded)
                .fontWidth(.expanded)
                .foregroundStyle(.accent)
            ForEach(checkListData) { item in
                StepView(
                    isChecked: item.isCompleted,
                    title: item.title
                )
            }
            .font(.targetFont(size: 16))
        }
        .padding(.horizontal, 35)
        .padding(.vertical, 30)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(Color.white)
        .cornerRadius(12)
        
    }
}

struct StepView: View {
    @State var isChecked: Bool = false
    var title: String
    func toggle() { isChecked = !isChecked }
    var body: some View {
        HStack{
            Button(action: toggle) {
                Image(systemName: isChecked ? "checkmark.square.fill" : "square")
                    .resizable()
                    .frame(width: 23, height: 23)
            }
            Text(title)
                .font(.targetFont(size: 16))
                .lineLimit(nil)
        }
    }
}
