//
//  Game.swift
//  gamescatalogue
//
//  Created by Alfa Centaury on 05/11/21.
//

import Foundation

struct Game: Equatable, Identifiable {
    let id: Int
    let name: String
    let released: String
    let backgroundImage: String
    let rating: Double
    let platforms: [String]
    let genres: [String]
}
