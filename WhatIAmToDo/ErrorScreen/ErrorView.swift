//
//  ErrorView.swift
//  WhatIAmToDo
//
//  Created by Юлия Гудошникова on 20.04.2025.
//

import SwiftUI

struct ErrorView: View {
    var retryAction: () -> Void
    
    var body: some View {
        VStack {
            Text("An error has occurred. Please check your internet connection or try again later.")
                .font(.title3)
                .foregroundColor(.accentColor)
                .multilineTextAlignment(.center)
                .padding()
            
            Button(action: retryAction) {
                Text("Try again")
                    .padding()
                    .background(Color.accentColor)
                    .foregroundColor(.white)
                    .cornerRadius(8)
            }
        }
        .padding()
        .padding(.vertical, 10)
        .background(Color.white)
        .cornerRadius(10)
        .overlay(
            RoundedRectangle(cornerRadius: 10)
                .stroke(Color.background, lineWidth: 3)
        )
    }
}

struct ClientErrorView: View {
    var retryAction: () -> Void
    
    var body: some View {
        VStack {
            Text("The request could not be processed.")
                .font(.title3)
                .foregroundColor(.accentColor)
                .multilineTextAlignment(.center)
                .padding()
            
            Button(action: retryAction) {
                Text("Try again")
                    .padding()
                    .background(Color.accentColor)
                    .foregroundColor(.white)
                    .cornerRadius(8)
            }
        }
        .padding()
        .padding(.vertical, 10)
        .background(Color.white)
        .cornerRadius(10)
        .overlay(
            RoundedRectangle(cornerRadius: 10)
                .stroke(Color.background, lineWidth: 3)
        )
    }
}

#Preview {
    ErrorView(retryAction: {})
}
