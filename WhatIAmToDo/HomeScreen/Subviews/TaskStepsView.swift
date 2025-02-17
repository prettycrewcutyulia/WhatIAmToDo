//
//  TaskStepsView.swift
//  WhatIAmToDo
//
//  Created by Юлия Гудошникова on 07.01.2025.
//

import SwiftUI

struct TaskStepsView: View {
    
    var checkListData: [TaskStep]

    var body: some View {
        VStack(alignment: .leading, spacing: 23) {
            Text("Choose your task")
                .font(.targetFont(size: 16).width(.expanded))
                .fontWeight(.heavy)
                .fontDesign(.rounded)
                .fontWidth(.expanded)
                .foregroundStyle(.accent)
            ForEach(checkListData) { item in
                Step(
                    isChecked: item.isChecked,
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

#Preview {
    TaskStepsView(checkListData: [
        TaskStep(id: "0", title: "Neopolitan"),
        TaskStep(id: "1",title: "New York"),
        TaskStep(id: "2",title:"Hawaiian"),
        TaskStep(id: "3",title:"Chicago Deep Dish"),
        TaskStep(id: "4",title:"Californian")
     ])
}


struct TaskStep: Identifiable {
    var id: String
    
     var isChecked: Bool = false
     var title: String
 }

struct Step: View {
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
        }
    }
}
