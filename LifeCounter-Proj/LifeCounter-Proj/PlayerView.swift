//
//  PlayerView.swift
//  LifeCounter-Proj
//
//  Created by Maansi Surve on 4/29/25.
//

import SwiftUI

struct PlayerView: View {
    let player: Player
    let onLifeChange: (Int) -> Void
    let onNameTap: () -> Void
    
    @State private var customAmount: String = "5"
    
    var body: some View {
        VStack(spacing: 8) {
            Button(action: onNameTap) {
                Text(player.name)
                    .font(.title2)
                    .fontWeight(.bold)
                    .foregroundColor(.primary)
                    .padding(.vertical, 4)
            }
            
            Text("\(player.lifeTotal)")
                .font(.system(size: 60))
                .fontWeight(.bold)
                .foregroundColor(player.lifeTotal <= 0 ? .red : .primary)
                .padding(.vertical, 10)
            
            HStack(spacing: 15) {
                VStack(spacing: 10) {
                    Button(action: { onLifeChange(1) }) {
                        LifeButton(text: "+", color: .green)
                    }
                    
                    Button(action: { onLifeChange(-1) }) {
                        LifeButton(text: "-", color: .red)
                    }
                }
                
                VStack(spacing: 10) {
                    HStack {
                        Button(action: {
                            if let amount = Int(customAmount) {
                                onLifeChange(amount)
                            }
                        }) {
                            LifeButton(text: "+", color: .green)
                        }
                        
                        TextField("", text: $customAmount)
                            .keyboardType(.numberPad)
                            .multilineTextAlignment(.center)
                            .frame(width: 40)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                    }
                    
                    HStack {
                        Button(action: {
                            if let amount = Int(customAmount) {
                                onLifeChange(-amount)
                            }
                        }) {
                            LifeButton(text: "-", color: .red)
                        }
                        
                        Text(customAmount)
                            .frame(width: 40)
                            .foregroundColor(.clear)
                    }
                }
            }
            .padding(.bottom, 10)
        }
        .padding()
        .frame(maxWidth: .infinity)
    }
}
