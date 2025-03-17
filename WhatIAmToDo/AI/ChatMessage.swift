//
//  ChatMessage.swift
//  WhatIAmToDo
//
//  Created by Юлия Гудошникова on 12.03.2025.
//


import SwiftUI

struct ChatMessage: Identifiable {
    let id = UUID()
    let text: String
    let isFromUser: Bool
}

struct ChatView: View {
    @StateObject private var viewModel = ChatViewModel()

    var body: some View {
        VStack {
            HStack {
                Spacer()
                Image(systemName: "lasso.badge.sparkles")
                    .resizable()
                    .frame(width: 48, height: 48)
                    .cornerRadius(12)
                Text("Your AI assistant")
                    .font(.targetFont(size: 20.3))
                    .fontWeight(.heavy)
                    .fontDesign(.rounded)
                    .foregroundStyle(Color.accentColor)
                Spacer()
            }
            .padding()

            // Chat history
            ScrollView {
                VStack(alignment: .leading, spacing: 16) {
                    ForEach(viewModel.messages) { message in
                        ChatBubble(text: message.text, isFromUser: message.isFromUser)
                    }

                    if viewModel.isTyping {
                        TypingIndicator()
                    }
                }
                .padding()
            }

            // Buttons, only if last message is from AI
            if viewModel.aiResponded {
                VStack {
                    Button("Generate another plan") {
                        viewModel.regeneratePlan()
                    }
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color(.accent))
                    .foregroundColor(.white)
                    .cornerRadius(8)

                    HStack {
                        Button("Reset") {
                            viewModel.resetChat()
                        }
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color(.accent))
                        .foregroundColor(.white)
                        .cornerRadius(8)

                        Button("Save") {
                            viewModel.safeAnswer()
                        }
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color(.accent))
                        .foregroundColor(.white)
                        .cornerRadius(8)
                    }
                }
                .padding()
            }

            // Text input
            if !viewModel.aiResponded {
                HStack {
                    TextField("Write your message", text: $viewModel.userInput)
                        .disabled(viewModel.aiResponded)
                        .frame(height: 48)
                        .padding(.leading, 8)
                        .background(.white)
                        .cornerRadius(12)

                    Button(action: viewModel.sendMessage) {
                        Image(systemName: "arrow.up.circle.fill")
                            .font(.largeTitle)
                            .foregroundColor(.accent)

                    }
                    .disabled(viewModel.aiResponded)
                }
                .padding(27)
            }
        }
        .background(Color.background)
    }
}

struct ChatBubble: View {
    let text: String
    let isFromUser: Bool

    var body: some View {
        HStack {
            if isFromUser {
                Spacer()
                Text(text)
                    .padding()
                    .background( Color(.accent))
                    .foregroundColor(.white)
                    .cornerRadius(8)
            } else {
                Image(systemName: "lasso.badge.sparkles") // AI icon
                    .font(.largeTitle)
                    .foregroundColor(.accentColor)

                Text(text)
                    .padding()
                    .background(Color(.white))
                    .foregroundColor(.accent)
                    .cornerRadius(8)
            }
        }
    }
}

struct ChatView_Previews: PreviewProvider {
    static var previews: some View {
        ChatView()
    }
}

struct TypingIndicator: View {
    var body: some View {
        HStack(spacing: 4) {
            Text("Your AI assistant is typing")
            TypingDots()
        }
        .foregroundColor(.gray)
        .padding()
        .background(.white)
        .cornerRadius(8)
    }
}

struct TypingDots: View {
    @State private var opacity: [Double] = [0.2, 0.2, 0.2]

    var body: some View {
        HStack(spacing: 3) {
            ForEach(0..<3) { index in
                Circle()
                    .frame(width: 5, height: 5)
                    .opacity(opacity[index])
            }
        }
        .onAppear {
            animateDots()
        }
    }

    private func animateDots() {
        for index in 0..<3 {
            DispatchQueue.main.asyncAfter(deadline: .now() + Double(index) * 0.3) {
                withAnimation(Animation.easeInOut(duration: 0.6).repeatForever(autoreverses: true)) {
                    opacity[index] = 1.0
                }
            }
        }
    }
}
