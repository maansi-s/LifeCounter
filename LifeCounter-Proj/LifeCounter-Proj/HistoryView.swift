//
//  HistoryView.swift
//  LifeCounter-Proj
//
//  Created by Maansi Surve on 5/3/25.
//

import SwiftUI

struct HistoryView: View {
    let history: [String]
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        NavigationView {
            VStack {
                if history.isEmpty {
                    Text("No game history yet")
                        .font(.title)
                        .foregroundColor(.gray)
                        .padding()
                } else {
                    List {
                        ForEach(0..<history.count, id: \.self) { index in
                            Text(history[index])
                                .padding(.vertical, 5)
                        }
                    }
                }
            }
            .navigationTitle("Game History")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Done") {
                        dismiss()
                    }
                }
            }
        }
    }
}
