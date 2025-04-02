//
//  LaunchScreenStateManager.swift
//  WhatIAmToDo
//
//  Created by Юлия Гудошникова on 07.01.2025.
//


import Foundation

final class LaunchScreenStateManager: ObservableObject {
// TODO: поменять на firstStep как только пройдет этап теста
    @MainActor @Published private(set) var state: LaunchScreenStep = .firstStep
    
    func start() {
        zeroFetch()
    }

    @MainActor func dismiss() {
        Task {
            state = .secondStep

            try? await Task.sleep(for: Duration.seconds(1))

            self.state = .finished 
        } 
    }
    
    private func zeroFetch() {
        let taskService: any TaskService = DIContainer.shared.resolve()
    
        let dispatchGroup = DispatchGroup()
        var fetchTaskSuccess = false
        dispatchGroup.enter()
        taskService.fetchTasks(completion: { result in
            if case .success(let goals) = result {
                fetchTaskSuccess = true
                dispatchGroup.leave()
            }
        })
        
        var fetchFiltersSuccess = false
        dispatchGroup.enter()
        taskService.fetchFilters(completion: { result in
            if case .success(let filters) = result {
                fetchFiltersSuccess = true
                dispatchGroup.leave()
            }
        })
        dispatchGroup.notify(queue: .main) {
            if fetchTaskSuccess && fetchFiltersSuccess {
                Task { @MainActor in
                    self.dismiss()
                }
            }
        }
    }

}
