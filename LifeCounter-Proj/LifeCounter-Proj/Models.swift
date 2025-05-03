//
//  Models.swift
//  LifeCounter-Proj
//
//  Created by Maansi Surve on 5/3/25.
//

import Foundation

struct Player: Identifiable {
    var id: UUID
    var name: String
    var lifeTotal: Int
}
