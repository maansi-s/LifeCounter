//
//  ContentView.swift
//  LifeCounter-Proj
//
//  Created by Maansi Surve on 4/29/25.
//

import SwiftUI

struct ContentView: View {
    @State private var player1Life = 20
    @State private var player2Life = 20
    
    var body: some View {
        GeometryReader { geometry in
            VStack(spacing: 0) {
                PlayerView(
                    playerName: "Player 1",
                    lifeTotal: $player1Life,
                    geometry: geometry
                )
                
                Rectangle()
                    .frame(height: 2)
                    .foregroundColor(.gray)
                
                PlayerView(
                    playerName: "Player 2",
                    lifeTotal: $player2Life,
                    geometry: geometry
                )
                
                if player1Life <= 0 || player2Life <= 0 {
                    GameResultView(losingPlayer: player1Life <= 0 ? "Player 1" : "Player 2")
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
