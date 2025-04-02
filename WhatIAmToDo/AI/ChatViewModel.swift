//
//  ChatViewModel.swift
//  WhatIAmToDo
//
//  Created by Юлия Гудошникова on 12.03.2025.
//

import SwiftUI
import Combine

class ChatViewModel: ObservableObject {
    @Published var userInput = ""
    @Published var messages: [ChatMessage] = [
        ChatMessage(text: "Hello!! I'm here to help you", isFromUser: false),
        ChatMessage(text: "Tell me what do you want to learn today?", isFromUser: false)
    ]
    @Published var isTyping = false
    @Published var aiResponded = false
    
    private var request: String?
    private var AIGoalResponse: GoalPlan?
    private var userDefaultsService: any UserDefaultsService
    private var taskService: any TaskService
    
    init(
        userDefaultsService: any UserDefaultsService,
         taskService: any TaskService
    ) {
        self.userDefaultsService = userDefaultsService
        self.taskService = taskService
        
    }

    func sendMessage() {
        guard !userInput.isEmpty else { return }

        let userMessage = ChatMessage(text: userInput, isFromUser: true)
        messages.append(userMessage)
        request = userInput
        let requestAI = AiGoalRequest(context: userInput)
        userInput = ""

        isTyping = true
        aiResponded = false

        
        let taskService: TaskService = DIContainer.shared.resolve()
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            taskService.getGoalUsingAI(request: requestAI, completion: { result in
                switch result {
                case let .success(plan):
                    self.AIGoalResponse = plan
                    let aiMessage = ChatMessage(text: plan.formattedDescription(), isFromUser: false)
                    self.messages.append(aiMessage)
                    self.isTyping = false
                    self.aiResponded = true
                    
                case .failure:
                    let aiMessage = ChatMessage(text: "Something went wrong", isFromUser: false)
                    self.messages.append(aiMessage)
                    self.isTyping = false
                    self.aiResponded = true
                }
            })
        }
    }

    func regeneratePlan() {
        if let lastIndex = messages.lastIndex(where: { !$0.isFromUser }) {
            messages.remove(at: lastIndex)
        }

        let requestAI = AiGoalRequest(context: request ?? "")
        isTyping = true
        aiResponded = false
        
        let taskService: TaskService = DIContainer.shared.resolve()

        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            taskService.getGoalUsingAI(request: requestAI, completion: { result in
                switch result {
                case let .success(plan):
                    self.AIGoalResponse = plan
                    let aiMessage = ChatMessage(text: plan.formattedDescription(), isFromUser: false)
                    self.messages.append(aiMessage)
                    self.isTyping = false
                    self.aiResponded = true
                    
                case .failure:
                    let aiMessage = ChatMessage(text: "Something went wrong", isFromUser: false)
                    self.messages.append(aiMessage)
                    self.isTyping = false
                    self.aiResponded = true
                }
            })
        }
    }

    func resetChat() {
        aiResponded = false
        messages = [
            ChatMessage(text: "Hello! I'm here to help you", isFromUser: false),
            ChatMessage(text: "Tell me what do you want to learn today?", isFromUser: false)
        ]
        userInput = ""
        request = nil
        
    }
    
    func safeAnswer() {
        
        var user = userDefaultsService.getUserIdAndUserToken()
        guard let id = user?.userId else {
            // TODO: добавить обработку ошибок
            return
        }
        if let AIGoalResponse {
            taskService.createGoal(
                goalRequest: GoalRequest.init(userId: id, goal: AIGoalResponse),
                completion: { _ in }
            )
        }
        
        aiResponded = false
    }
}
