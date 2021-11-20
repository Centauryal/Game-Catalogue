//
//  Detail.swift
//  gamescatalogue
//
//  Created by Alfa Centaury on 05/11/21.
//

import Foundation

struct Detail: Equatable, Identifiable {
    let id: Int
    let name: String
    let description: String
    let released: String
    let backgroundImage: String
    let backgroundImageAdditional: String
    let rating: Double
    let platforms: [String]
    let genres: [String]
    let publishers: [String]
}
