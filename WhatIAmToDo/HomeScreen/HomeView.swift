//
//  HomeView.swift
//  WhatIAmToDo
//
//  Created by Юлия Гудошникова on 04.01.2025.
//

import SwiftUI

struct HomeView: View {
    @State private var date = Date()
    @State private var selectedDates: Set<DateComponents> = [DateComponents(year: 2025, month: 1, day: 17), DateComponents(year: 2025, month: 1, day: 18), DateComponents(year: 2025, month: 1, day: 19)]
    
    let checkListData = [
        TaskStep(id: "0", title: "Neopolitan"),
        TaskStep(id: "1",title: "New York"),
        TaskStep(id: "2",title:"Hawaiian"),
        TaskStep(id: "3",title:"Chicago Deep Dish"),
        TaskStep(id: "4",title:"Californian")
     ]

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: Constants.spacing) {
                title
                ChooseTaskBar()
                CalendarView(selectedDates: $selectedDates)
                
                progressStack
                
                TaskStepsView(checkListData: checkListData)
            }
            .padding(Constants.paddingInsets)
        }
    }
    
    private var title: some View {
        Text("Report")
            .font(.targetFont(size: 20.3))
            .fontWeight(.heavy)
            .fontDesign(.rounded)
            .foregroundStyle(Color.accentColor)
    }
    
    private var progressStack: some View {
        HStack {
            ProgressView(progress: "3/8", title: "Progress")
            Spacer()
            ProgressView(progress: "5", title: "Days")
        }
    }
}

private enum Constants {
    static let paddingInsets: CGFloat = 20
    static let spacing: CGFloat = 20
    static let steppersWidth: CGFloat = 311
}

#Preview {
    HomeView()
}
