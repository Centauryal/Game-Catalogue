//
//  GamesResponse.swift
//  gamescatalogue
//
//  Created by Alfa Centaury on 28/08/21.
//

import Foundation

struct GamesResponse: Codable {

    let count: Int
    let next: String
    let previous: String?
    let results: [ResultsGames]

    private enum CodingKeys: String, CodingKey {
        case count = "count"
        case next = "next"
        case previous = "previous"
        case results = "results"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        count = try values.decode(Int.self, forKey: .count)
        next = try values.decode(String.self, forKey: .next)
        previous = try? values.decode(String.self, forKey: .previous)
        results = try values.decode([ResultsGames].self, forKey: .results)
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(count, forKey: .count)
        try container.encode(next, forKey: .next)
        try container.encode(next, forKey: .previous)
        try container.encode(results, forKey: .results)
    }

}

struct ResultsGames: Codable {

    let id: Int
    let name: String
    let released: String
    let backgroundImage: String
    let rating: Double
    let platforms: [Platforms]
    let genres: [Genres]

    private enum CodingKeys: String, CodingKey {
        case id = "id"
        case name = "name"
        case released = "released"
        case backgroundImage = "background_image"
        case rating = "rating"
        case platforms = "platforms"
        case genres = "genres"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decode(Int.self, forKey: .id)
        name = try values.decode(String.self, forKey: .name)
        released = try values.decode(String.self, forKey: .released)
        backgroundImage = try values.decode(String.self, forKey: .backgroundImage)
        rating = try values.decode(Double.self, forKey: .rating)
        platforms = try values.decode([Platforms].self, forKey: .platforms)
        genres = try values.decode([Genres].self, forKey: .genres)
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(name, forKey: .name)
        try container.encode(released, forKey: .released)
        try container.encode(backgroundImage, forKey: .backgroundImage)
        try container.encode(rating, forKey: .rating)
        try container.encode(platforms, forKey: .platforms)
        try container.encode(genres, forKey: .genres)
    }

}

struct Platforms: Codable {

    let platform: Platform
    let releasedAt: String?
    let requirementsEn: String?
    let requirementsRu: String?

    private enum CodingKeys: String, CodingKey {
        case platform = "platform"
        case releasedAt = "released_at"
        case requirementsEn = "requirements_en"
        case requirementsRu = "requirements_ru"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        platform = try values.decode(Platform.self, forKey: .platform)
        releasedAt = try? values.decode(String.self, forKey: .releasedAt)
        requirementsEn = try? values.decode(String.self, forKey: .requirementsEn)
        requirementsRu = try? values.decode(String.self, forKey: .requirementsRu)
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(platform, forKey: .platform)
        try container.encode(releasedAt, forKey: .releasedAt)
        try container.encode(releasedAt, forKey: .requirementsEn)
        try container.encode(releasedAt, forKey: .requirementsRu)
    }

}

struct Platform: Codable {

    let id: Int
    let name: String
    let slug: String
    let image: String?
    let yearEnd: String?
    let yearStart: Int?
    let gamesCount: Int?
    let imageBackground: String?

    private enum CodingKeys: String, CodingKey {
        case id = "id"
        case name = "name"
        case slug = "slug"
        case image = "image"
        case yearEnd = "year_end"
        case yearStart = "year_start"
        case gamesCount = "games_count"
        case imageBackground = "image_background"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decode(Int.self, forKey: .id)
        name = try values.decode(String.self, forKey: .name)
        slug = try values.decode(String.self, forKey: .slug)
        image = try? values.decode(String.self, forKey: .image)
        yearEnd = try? values.decode(String.self, forKey: .yearEnd)
        yearStart = try? values.decode(Int.self, forKey: .yearStart)
        gamesCount = try? values.decode(Int.self, forKey: .gamesCount)
        imageBackground = try? values.decode(String.self, forKey: .imageBackground)
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(name, forKey: .name)
        try container.encode(slug, forKey: .slug)
        try container.encode(slug, forKey: .image)
        try container.encode(slug, forKey: .yearEnd)
        try container.encode(yearStart, forKey: .yearStart)
        try container.encode(gamesCount, forKey: .gamesCount)
        try container.encode(imageBackground, forKey: .imageBackground)
    }

}

struct Genres: Codable {

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
