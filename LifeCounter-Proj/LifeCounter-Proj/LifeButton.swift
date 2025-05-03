//
//  LifeButton.swift
//  LifeCounter-Proj
//
//  Created by Maansi Surve on 4/29/25.
//

import SwiftUI

struct LifeButton: View {
    let text: String
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            Text(text)
                .font(.title)
                .fontWeight(.bold)
                .foregroundColor(.white)
                .frame(width: 50, height: 50)
                .background(text.contains("+") ? Color.green : Color.red)
                .cornerRadius(10)
        }
    }
}
