//
//  ContentView.swift
//  LifeCounter-Proj
//
//  Created by Maansi Surve on 4/29/25.
//

import SwiftUI

struct ContentView: View {
    @State private var players: [Player] = [
        Player(id: UUID(), name: "Player 1", lifeTotal: 20),
        Player(id: UUID(), name: "Player 2", lifeTotal: 20),
        Player(id: UUID(), name: "Player 3", lifeTotal: 20),
        Player(id: UUID(), name: "Player 4", lifeTotal: 20)
    ]
    @State private var history: [String] = []
    @State private var gameStarted = false
    @State private var gameOver = false
    @State private var showHistory = false
    @State private var selectedPlayer: Player?
    @State private var showNameDialog = false
    @State private var newPlayerName = ""
    
    var body: some View {
        GeometryReader { geometry in
            VStack {
                TopControlsView(
                    gameStarted: gameStarted,
                    playerCount: players.count,
                    onAddPlayer: addPlayer,
                    onShowHistory: { showHistory = true },
                    onResetGame: resetGame
                )
                
                ScrollView {
                    PlayerGridView(
                        players: players,
                        updateLife: updateLife,
                        onNameTap: { player in
                            selectedPlayer = player
                            newPlayerName = player.name
                            showNameDialog = true
                        }
                    )
                }
                
                if gameOver {
                    GameOverView(
                        players: players,
                        onReset: resetGame
                    )
                }
            }
            .sheet(isPresented: $showHistory) {
                HistoryView(history: history)
            }
            .alert("Enter New Name", isPresented: $showNameDialog) {
                TextField("Name", text: $newPlayerName)
                Button("Cancel", role: .cancel) { }
                Button("OK") {
                    updatePlayerName()
                }
            }
        }
    }
    
    private func addPlayer() {
        if players.count < 8 {
            let newPlayer = Player(id: UUID(), name: "Player \(players.count + 1)", lifeTotal: 20)
            players.append(newPlayer)
        }
    }
    
    private func updatePlayerName() {
        if let index = players.firstIndex(where: { $0.id == selectedPlayer?.id }) {
            let oldName = players[index].name
            players[index].name = newPlayerName
            history.append("\(oldName) changed name to \(newPlayerName).")
        }
    }
    
    private func updateLife(for player: Player, change: Int) {
        if !gameStarted && change != 0 {
            gameStarted = true
        }
        
        if let index = players.firstIndex(where: { $0.id == player.id }) {
            let oldLife = players[index].lifeTotal
            players[index].lifeTotal += change
            players[index].lifeTotal = min(players[index].lifeTotal, 999)
            
            if change != 0 {
                let changeText = change > 0 ? "gained \(change)" : "lost \(abs(change))"
                history.append("\(player.name) \(changeText) life. (\(oldLife) → \(players[index].lifeTotal))")
            }
            
            checkGameOver()
        }
    }
    
    private func checkGameOver() {
        let playersAlive = players.filter { $0.lifeTotal > 0 }
        gameOver = playersAlive.count <= 1 && players.count > 1
    }
    
    private func resetGame() {
        for i in 0..<players.count {
            players[i].lifeTotal = 20
        }
        history.append("Game reset.")
        gameStarted = false
        gameOver = false
    }
}

struct TopControlsView: View {
    let gameStarted: Bool
    let playerCount: Int
    let onAddPlayer: () -> Void
    let onShowHistory: () -> Void
    let onResetGame: () -> Void
    
    var body: some View {
        HStack {
            Button(action: onAddPlayer) {
                Text("Add Player")
                    .padding(.horizontal, 10)
                    .padding(.vertical, 5)
                    .background(gameStarted ? Color.gray : Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(5)
            }
            .disabled(gameStarted || playerCount >= 8)
            
            Spacer()
            
            Button(action: onShowHistory) {
                Text("History")
                    .padding(.horizontal, 10)
                    .padding(.vertical, 5)
                    .background(Color.green)
                    .foregroundColor(.white)
                    .cornerRadius(5)
            }
            
            Button(action: onResetGame) {
                Text("Reset")
                    .padding(.horizontal, 10)
                    .padding(.vertical, 5)
                    .background(Color.red)
                    .foregroundColor(.white)
                    .cornerRadius(5)
            }
        }
        .padding(.horizontal)
        .padding(.top, 10)
    }
}

struct PlayerGridView: View {
    let players: [Player]
    let updateLife: (Player, Int) -> Void
    let onNameTap: (Player) -> Void
    
    var body: some View {
        LazyVGrid(columns: [GridItem(.adaptive(minimum: 300))], spacing: 10) {
            ForEach(players) { player in
                PlayerView(
                    player: player,
                    onLifeChange: { change in
                        updateLife(player, change)
                    },
                    onNameTap: {
                        onNameTap(player)
                    }
                )
                .background(getPlayerColor(player: player, players: players))
                .cornerRadius(10)
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(Color.gray, lineWidth: 1)
                )
                .padding(.horizontal, 5)
            }
        }
        .padding()
    }
    
    private func getPlayerColor(player: Player, players: [Player]) -> Color {
        if let index = players.firstIndex(where: { $0.id == player.id }) {
            switch index {
            case 0: return Color.blue.opacity(0.2)
            case 1: return Color.red.opacity(0.2)
            case 2: return Color.green.opacity(0.2)
            case 3: return Color.orange.opacity(0.2)
            case 4: return Color.purple.opacity(0.2)
            case 5: return Color.pink.opacity(0.2)
            case 6: return Color.teal.opacity(0.2)
            default: return Color.indigo.opacity(0.2)
            }
        }
        return Color.gray.opacity(0.2)
    }
}

struct GameOverView: View {
    let players: [Player]
    let onReset: () -> Void
    
    var body: some View {
        let winner = players.first(where: { $0.lifeTotal > 0 })
        
        VStack {
            Text("Game over!")
                .font(.title)
                .fontWeight(.bold)
                .foregroundColor(.red)
            
            if let winner = winner {
                Text("\(winner.name) wins!")
                    .font(.title2)
                    .fontWeight(.bold)
                    .foregroundColor(.green)
            }
            
            Button(action: onReset) {
                Text("OK")
                    .padding(.horizontal, 30)
                    .padding(.vertical, 10)
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(8)
            }
            .padding()
        }
        .frame(maxWidth: .infinity)
        .background(Color.black.opacity(0.1))
        .cornerRadius(10)
        .padding()
    }
}

#Preview {
    ContentView()
}

