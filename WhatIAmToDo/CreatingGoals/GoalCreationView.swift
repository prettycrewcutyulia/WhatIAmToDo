//
//  Step.swift
//  WhatIAmToDo
//
//  Created by Юлия Гудошникова on 02.03.2025.
//

import SwiftUI

struct Step: Identifiable {
    let id = UUID()
    var title: String
    var isCompleted: Bool = false
}

struct AddTaskView: View {
    @State private var taskTitle: String = ""
    @State private var steps: [Step] = [
        Step(title: "Buy some paints in special sh..."),
        Step(title: "Find ou")
    ]
    @State private var newStepTitle: String = ""
    @State private var showNewStepField: Bool = false
    @State private var startDate: Date? = nil
    @State private var deadline: Date? = nil
    
    var body: some View {
        NavigationView {
            VStack(alignment: .leading, spacing: 20) {
                Text("Add your own task")
                    .font(.targetFont(size: 20.3))
                    .fontWeight(.heavy)
                    .fontDesign(.rounded)
                    .foregroundStyle(Color.accentColor)
                    .padding(.top, 20)
                
                TextField("Write a title", text: $taskTitle)
                    .padding()
                    .background(Color.white)
                    .cornerRadius(10)
                
                VStack(alignment: .leading) {
                    HStack {
                        if let startDate = startDate {
                            DatePicker("Start Date", selection: Binding($startDate, default: startDate), displayedComponents: .date)
                            
                            Button(action: {
                                self.startDate = nil
                            }) {
                                Image(systemName: "xmark.circle.fill")
                                    .resizable()
                                    .frame(width: 23, height: 23)
                                    .foregroundColor(.accentColor)

                            }
                        } else {
                            Button(action: {
                                self.startDate = Date()
                            }) {
                                Text("Set Start Date")
                            }
                        }
                    }

                    HStack {
                        if let deadline = deadline {
                            DatePicker("Deadline", selection: Binding($deadline, default: deadline), displayedComponents: .date)
                            
                            Button(action: {
                                self.deadline = nil
                            }) {
                                Image(systemName: "xmark.circle.fill")
                                    .foregroundColor(.accentColor)
                            }
                        } else {
                            Button(action: {
                                self.deadline = Date()
                            }) {
                                Text("Set Deadline")
                            }
                        }
                    }
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(24)
                .background(Color.white)
                .cornerRadius(10)
                
                VStack(alignment: .leading, spacing: 24) {
                    Text("Add some steps")
                        .font(.headline)
                        .bold()
                        .padding(.bottom, 5)
                    
                    ForEach($steps) { $step in
                        HStack {
                            Button(action: {
                                step.isCompleted.toggle()
                            }) {
                                Image(systemName: step.isCompleted ? "checkmark.square" : "square")
                                    .resizable()
                                    .frame(width: 23, height: 23)
                                    .foregroundColor(.primary)
                            }
                            
                            TextField("Step Title", text: $step.title)
                                .strikethrough(step.isCompleted, color: .primary)
                                .disabled(step.isCompleted)
                            
                            Spacer()
                        }
                        .padding(.vertical, 5)
                    }
                    if showNewStepField {
                        HStack {
                            TextField("New step", text: $newStepTitle)
                                .textFieldStyle(RoundedBorderTextFieldStyle())
                            
                            Button(action: {
                                if !newStepTitle.isEmpty {
                                    steps.append(Step(title: newStepTitle))
                                    newStepTitle = ""
                                    showNewStepField = false
                                }
                            }) {
                                Image(systemName: "checkmark.circle.fill")
                                    .resizable()
                                    .frame(width: 23, height: 23)
                                

                            }
                        }
                    } else {
                        Button(action: {
                            showNewStepField = true
                        }) {
                            Image(systemName: "plus")
                                .resizable()
                                .frame(width: 23, height: 23)
                        }
                    }
                }
                .padding(32)
                .background(Color.white)
                .cornerRadius(10)
                
                Spacer()
            }
            .padding(.horizontal)
            .background(Color.background)
            .foregroundStyle(Color.accentColor)
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

extension Binding {
    init(_ binding: Binding<Value?>, default defaultValue: Value) {
        self.init(
            get: { binding.wrappedValue ?? defaultValue },
            set: { newValue in
                binding.wrappedValue = newValue
            }
        )
    }
}

struct AddTaskView_Previews: PreviewProvider {
    static var previews: some View {
        AddTaskView()
    }
}
