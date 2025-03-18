//
//  Text+Extension.swift
//  WhatIAmToDo
//
//  Created by Юлия Гудошникова on 19.03.2025.
//

import SwiftUI

extension View {
    func title() -> some View {
        self
            .font(.targetFont(size: 20.3))
            .fontWeight(.heavy)
            .fontDesign(.rounded)
            .foregroundStyle(Color.accentColor)
    }
}
