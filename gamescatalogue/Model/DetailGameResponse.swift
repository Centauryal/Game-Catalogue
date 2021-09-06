//
//  DetailGameResponse.swift
//  gamescatalogue
//
//  Created by Alfa Centaury on 31/08/21.
//

import Foundation

struct DetailGameResponse: Codable {

    let id: Int
    let name: String
    let description: String
    let released: String
    let backgroundImage: String
    let backgroundImageAdditional: String?
    let rating: Double
    let platforms: [Platforms]
    let genres: [Genres]
    let publishers: [Publishers]

    private enum CodingKeys: String, CodingKey {
        case id = "id"
        case name = "name"
        case description = "description"
        case released = "released"
        case backgroundImage = "background_image"
        case backgroundImageAdditional = "background_image_additional"
        case rating = "rating"
        case platforms = "platforms"
        case genres = "genres"
        case publishers = "publishers"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decode(Int.self, forKey: .id)
        name = try values.decode(String.self, forKey: .name)
        description = try values.decode(String.self, forKey: .description)
        released = try values.decode(String.self, forKey: .released)
        backgroundImage = try values.decode(String.self, forKey: .backgroundImage)
        backgroundImageAdditional = try? values.decode(String.self, forKey: .backgroundImageAdditional)
        rating = try values.decode(Double.self, forKey: .rating)
        platforms = try values.decode([Platforms].self, forKey: .platforms)
        genres = try values.decode([Genres].self, forKey: .genres)
        publishers = try values.decode([Publishers].self, forKey: .publishers)
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(name, forKey: .name)
        try container.encode(description, forKey: .description)
        try container.encode(released, forKey: .released)
        try container.encode(backgroundImage, forKey: .backgroundImage)
        try container.encode(backgroundImageAdditional, forKey: .backgroundImageAdditional)
        try container.encode(rating, forKey: .rating)
        try container.encode(platforms, forKey: .platforms)
        try container.encode(genres, forKey: .genres)
        try container.encode(publishers, forKey: .publishers)
    }

}

struct Publishers: Codable {

    let id: Int
    let name: String
    let slug: String
    let gamesCount: Int
    let imageBackground: String

    private enum CodingKeys: String, CodingKey {
        case id = "id"
        case name = "name"
        case slug = "slug"
        case gamesCount = "games_count"
        case imageBackground = "image_background"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decode(Int.self, forKey: .id)
        name = try values.decode(String.self, forKey: .name)
        slug = try values.decode(String.self, forKey: .slug)
        gamesCount = try values.decode(Int.self, forKey: .gamesCount)
        imageBackground = try values.decode(String.self, forKey: .imageBackground)
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(name, forKey: .name)
        try container.encode(slug, forKey: .slug)
        try container.encode(gamesCount, forKey: .gamesCount)
        try container.encode(imageBackground, forKey: .imageBackground)
    }

}


