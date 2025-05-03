//
//  GameResultView.swift
//  LifeCounter-Proj
//
//  Created by Maansi Surve on 4/29/25.
//

import SwiftUI

struct GameResultView: View {
    let losingPlayer: String
    
    var body: some View {
        Text("\(losingPlayer) LOSES!")
            .font(.title)
            .fontWeight(.bold)
            .foregroundColor(.red)
            .padding()
            .frame(maxWidth: .infinity)
            .background(Color.black.opacity(0.1))
    }
}
