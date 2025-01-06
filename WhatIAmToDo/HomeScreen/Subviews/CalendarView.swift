//
//  CalendarView.swift
//  WhatIAmToDo
//
//  Created by Юлия Гудошникова on 04.01.2025.
//

import SwiftUI

struct CalendarView: View {
    @State private var currentDate = Date()
    
    private var daysOfWeek: [String] {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "ru_RU")
        return formatter.shortWeekdaySymbols
    }
    
    private func datesInMonth() -> [Date] {
        guard let monthInterval = Calendar.current.dateInterval(of: .month, for: currentDate) else {
            return []
        }
        
        var dates: [Date] = []
        var date = monthInterval.start
        
        while date < monthInterval.end {
            dates.append(date)
            date = Calendar.current.date(byAdding: .day, value: 1, to: date)!
        }
        
        return dates
    }
    
    private func isSameDay(date1: Date, date2: Date) -> Bool {
        Calendar.current.isDate(date1, inSameDayAs: date2)
    }
    
    var body: some View {
        VStack {
            HStack {
                Button(action: {
                    changeMonth(by: -1)
                }) {
                    Image(systemName: "chevron.left")
                }
                
                Spacer()
                
                Text(getMonthYearString(date: currentDate))
                    .font(.title)
                
                Spacer()
                
                Button(action: {
                    changeMonth(by: 1)
                }) {
                    Image(systemName: "chevron.right")
                }
            }
            .padding()
            
            HStack {
                ForEach(daysOfWeek, id: \.self) { day in
                    Text(day)
                        .font(.headline)
                        .frame(maxWidth: .infinity)
                }
            }
            
            let monthDates = datesInMonth()
            let firstDayOffset = Calendar.current.component(.weekday, from: monthDates.first!)
            
            LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: 7)) {
                ForEach(0..<monthDates.count + firstDayOffset - 1, id: \.self) { index in
                    if index < firstDayOffset - 1 {
                        Color.clear
                    } else {
                        Text("\(Calendar.current.component(.day, from: monthDates[index - firstDayOffset + 1]))")
                            .padding()
                            .background(isSameDay(date1: monthDates[index - firstDayOffset + 1], date2: Date()) ? Color.blue.opacity(0.2) : Color.clear)
                            .cornerRadius(8)
                    }
                }
            }
        }
        .padding()
    }
    
    private func changeMonth(by value: Int) {
        currentDate = Calendar.current.date(byAdding: .month, value: value, to: currentDate)!
    }
    
    private func getMonthYearString(date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "LLLL yyyy"
        return formatter.string(from: date)
    }
}

struct ContentView: View {
    var body: some View {
        CalendarView()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
