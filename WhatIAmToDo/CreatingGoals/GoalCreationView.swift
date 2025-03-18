import SwiftUI

struct AddEditTaskView: View {
    @StateObject private var viewModel: TaskViewModel
    
    init(task: Goal? = nil) {
        _viewModel = StateObject(wrappedValue: TaskViewModel(task: task, taskService: DIContainer.shared.resolve()))
    }
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(alignment: .leading, spacing: 20) {
                    Text(viewModel.isEditing ? "Edit your task" : "Add your own task")
                        .title()
                    
                    TextField("Write a title", text: $viewModel.taskTitle)
                        .padding()
                        .background(Color.white)
                        .cornerRadius(10)
                    
                    VStack(alignment: .leading) {
                        // Управление датами
                        HStack {
                            if let startDate = viewModel.startDate {
                                DatePicker("Start Date", selection: Binding($viewModel.startDate, default: startDate), displayedComponents: .date)
                                
                                Button(action: {
                                    viewModel.removeStartDate()
                                }) {
                                    Image(systemName: "xmark.circle.fill")
                                        .resizable()
                                        .frame(width: 23, height: 23)
                                        .foregroundColor(.accentColor)
                                }
                            } else {
                                Button(action: {
                                    viewModel.addStartDate()
                                }) {
                                    Text("Set Start Date")
                                }
                            }
                        }
                        
                        HStack {
                            if let deadline = viewModel.deadline {
                                DatePicker("Deadline", selection: Binding($viewModel.deadline, default: deadline), displayedComponents: .date)
                                
                                Button(action: {
                                    viewModel.removeDeadline()
                                }) {
                                    Image(systemName: "xmark.circle.fill")
                                        .resizable()
                                        .frame(width: 23, height: 23)
                                        .foregroundColor(.accentColor)
                                }
                            } else {
                                Button(action: {
                                    viewModel.addDeadline()
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
                        
                        ForEach(viewModel.steps.indices, id: \.self) { index in
                            VStack(spacing: .zero) {
                                HStack {
                                    Button(action: {
                                        viewModel.toggleStepCompletion(index: index)
                                    }) {
                                        Image(systemName: viewModel.steps[index].isCompleted ? "checkmark.square" : "square")
                                            .resizable()
                                            .frame(width: 23, height: 23)
                                            .foregroundColor(.primary)
                                    }
                                    
                                    TextField("Step Title", text: $viewModel.steps[index].title, axis: .vertical)
                                        .strikethrough(viewModel.steps[index].isCompleted, color: .primary)
                                        .disabled(viewModel.steps[index].isCompleted)
                                        .lineLimit(nil)
                                    
                                    Spacer()
                                }
                                
                                HStack {
                                    Spacer()
                                    if let stepDeadline = viewModel.steps[index].deadline {
                                        DatePicker(
                                            "Step Deadline",
                                            selection: Binding(get: {
                                                stepDeadline
                                            }, set: { newDate in
                                                viewModel.addStepDeadline(index: index, deadline: newDate)
                                            }),
                                            displayedComponents: .date
                                        )
                                        
                                        Button(action: {
                                            viewModel.removeStepDeadline(index: index)
                                        }) {
                                            Image(systemName: "xmark.circle.fill")
                                                .resizable()
                                                .frame(width: 23, height: 23)
                                                .foregroundColor(.accentColor)
                                        }
                                    } else {
                                        Button(action: {
                                            viewModel.addStepDeadline(index: index, deadline: Date())
                                        }) {
                                            Text("Set Step Deadline")
                                        }
                                    }
                                }
                            }
                            .padding(.vertical, 5)
                            
                        }
                        
                        if viewModel.showNewStepField {
                            HStack {
                                TextField("New step", text: $viewModel.newStepTitle, axis: .vertical)
                                    .textFieldStyle(RoundedBorderTextFieldStyle())
                                    .lineLimit(nil)
                                
                                Button(action: {
                                    viewModel.addStep()
                                }) {
                                    Image(systemName: "checkmark.circle.fill")
                                        .resizable()
                                        .frame(width: 23, height: 23)
                                }
                            }
                        } else {
                            Button(action: {
                                viewModel.showNewStepField = true
                            }) {
                                Image(systemName: "plus")
                                    .resizable()
                                    .frame(width: 23, height: 23)
                            }
                        }
                    }
                    .padding(32)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .background(Color.white)
                    .cornerRadius(10)
                    
                    filtersView
                        .padding(32)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .background(Color.white)
                        .cornerRadius(10)
                    
                    Button("Save") {
                        if viewModel.isEditing {
                            viewModel.updateGoal()
                        } else {
                            viewModel.saveGoal()
                        }
                    }
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color(.accent))
                    .foregroundColor(.white)
                    .cornerRadius(8)
                    Spacer()
                }
            }
            .padding(.horizontal)
            .background(Color.background)
            .foregroundStyle(Color.accentColor)
        }
        .navigationTitle("")
    }
    
    var filtersView: some View {
        HStack {
            Text("Filters")
            ForEach(Array(viewModel.categories), id: \.self) { category in
                category.color
                    .frame(width: 23, height: 23)
                    .cornerRadius(3)
            }
        }
        .onTapGesture {
            viewModel.isBottomSheetPresented.toggle()
        }
        .sheet(isPresented: $viewModel.isBottomSheetPresented) {
            FiltersBottomSheetSelectedView(
                selectedCategory: $viewModel.categories,
                filters: viewModel.filters,
                isPresented: $viewModel.isBottomSheetPresented
            )
            .cornerRadius(55)
            .background(Color.background)
            .ignoresSafeArea()
            .presentationDetents([.medium, .large])
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
        AddEditTaskView()
    }
}
