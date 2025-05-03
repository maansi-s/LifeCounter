//
//  PlayerView.swift
//  LifeCounter-Proj
//
//  Created by Maansi Surve on 4/29/25.
//

import SwiftUI

struct PlayerView: View {
    let playerName: String
    @Binding var lifeTotal: Int
    let geometry: GeometryProxy
    
    private var isLandscape: Bool {
        geometry.size.width > geometry.size.height
    }
    
    private var contentHeight: CGFloat {
        isLandscape ? geometry.size.height / 2 : geometry.size.height / 2.2
    }
    
    var body: some View {
        Group {
            if isLandscape {
                landscapeLayout
            } else {
                portraitLayout
            }
        }
        .background(playerName == "Player 1" ? Color.blue.opacity(0.2) : Color.red.opacity(0.2))
    }
    
    private var landscapeLayout: some View {
        HStack {
            VStack {
                Text(playerName)
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .padding(.bottom, 4)
                
                Text("\(lifeTotal)")
                    .font(.system(size: min(geometry.size.width, geometry.size.height) * 0.2))
                    .fontWeight(.bold)
            }
            .frame(width: geometry.size.width * 0.5)
            
            HStack(spacing: 20) {
                VStack(spacing: 12) {
                    LifeButton(text: "+", action: { updateLife(change: 1) })
                    LifeButton(text: "-", action: { updateLife(change: -1) })
                }
                
                VStack(spacing: 12) {
                    LifeButton(text: "+5", action: { updateLife(change: 5) })
                    LifeButton(text: "-5", action: { updateLife(change: -5) })
                }
            }
            .padding(.horizontal)
        }
        .frame(height: contentHeight)
    }
    
    private var portraitLayout: some View {
        VStack {
            Text(playerName)
                .font(.largeTitle)
                .fontWeight(.bold)
            
            Text("\(lifeTotal)")
                .font(.system(size: min(geometry.size.width, contentHeight) * 0.25))
                .fontWeight(.bold)
                .padding(.vertical, 10)
            
            HStack(spacing: 20) {
                HStack(spacing: 15) {
                    LifeButton(text: "+", action: { updateLife(change: 1) })
                    LifeButton(text: "-", action: { updateLife(change: -1) })
                }
                
                HStack(spacing: 15) {
                    LifeButton(text: "+5", action: { updateLife(change: 5) })
                    LifeButton(text: "-5", action: { updateLife(change: -5) })
                }
            }
            .padding(.horizontal)
        }
        .frame(height: contentHeight)
    }
    
    private func updateLife(change: Int) {
        lifeTotal += change
        lifeTotal = min(lifeTotal, 999)
    }
}
