//
//  LifeButton.swift
//  LifeCounter-Proj
//
//  Created by Maansi Surve on 4/29/25.
//

import SwiftUI

struct LifeButton: View {
    let text: String
    let color: Color
    
    var body: some View {
        Text(text)
            .font(.title)
            .fontWeight(.bold)
            .foregroundColor(.white)
            .frame(width: 40, height: 40)
            .background(color)
            .cornerRadius(10)
    }
}
