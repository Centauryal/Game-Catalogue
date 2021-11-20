//
//  GameDB.swift
//  gamescatalogue
//
//  Created by Alfa Centaury on 05/11/21.
//

import Foundation

struct GameDB: Equatable, Identifiable {
    let id: Int32
    let name: String
    let image: String
    let imageBackground: String
    let desc: String
    let releaseDate: String
    let genre: String
    let platform: String
    let publisher: String
    let rating: Double
}
