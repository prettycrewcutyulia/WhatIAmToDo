//
//  ProgressView.swift
//  WhatIAmToDo
//
//  Created by Юлия Гудошникова on 04.01.2025.
//

import SwiftUI

struct ProgressView: View {
    @State var progress: String = "⎯"
    @State var title: String

    var body: some View {
        ZStack {
            RoundedRectangle(
                cornerRadius: 12,
                style: .continuous
            )
            .fill(Color.white)
            
            VStack(spacing: 15) {
                Text(title)
                    .font(.targetFont(size: 16))
                    .fontWeight(.heavy)
                    .fontDesign(.rounded)
                Text(progress)
                    .font(.targetFont(size: 16))
            }
            .foregroundStyle(Color.accentColor)
                
        }
        .frame(width: 140, height: 120)
    }
}
