//
//  GameDB.swift
//  gamescatalogue
//
//  Created by Alfa Centaury on 05/11/21.
//

public struct GameDB: Equatable, Identifiable {
    public init(id: Int32,
                name: String,
                image: String,
                imageBackground: String,
                desc: String,
                releaseDate: String,
                genre: String,
                platform: String,
                publisher: String,
                rating: Double) {
        self.id = id
        self.name = name
        self.image = image
        self.imageBackground = imageBackground
        self.desc = desc
        self.releaseDate = releaseDate
        self.genre = genre
        self.platform = platform
        self.publisher = publisher
        self.rating = rating
    }
    
    public let id: Int32
    public let name: String
    public let image: String
    public let imageBackground: String
    public let desc: String
    public let releaseDate: String
    public let genre: String
    public let platform: String
    public let publisher: String
    public let rating: Double
}
