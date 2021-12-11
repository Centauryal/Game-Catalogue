//
//  File.swift
//  
//
//  Created by Alfa Centaury on 07/12/21.
//

import Foundation

public struct GamesResponse: Codable {

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

    public init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        count = try values.decode(Int.self, forKey: .count)
        next = try values.decode(String.self, forKey: .next)
        previous = try? values.decode(String.self, forKey: .previous)
        results = try values.decode([ResultsGames].self, forKey: .results)
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(count, forKey: .count)
        try container.encode(next, forKey: .next)
        try container.encode(next, forKey: .previous)
        try container.encode(results, forKey: .results)
    }

}

public struct ResultsGames: Codable {

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

    public init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decode(Int.self, forKey: .id)
        name = try values.decode(String.self, forKey: .name)
        released = try values.decode(String.self, forKey: .released)
        backgroundImage = try values.decode(String.self, forKey: .backgroundImage)
        rating = try values.decode(Double.self, forKey: .rating)
        platforms = try values.decode([Platforms].self, forKey: .platforms)
        genres = try values.decode([Genres].self, forKey: .genres)
    }

    public func encode(to encoder: Encoder) throws {
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

public struct Platforms: Codable {

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

    public init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        platform = try values.decode(Platform.self, forKey: .platform)
        releasedAt = try? values.decode(String.self, forKey: .releasedAt)
        requirementsEn = try? values.decode(String.self, forKey: .requirementsEn)
        requirementsRu = try? values.decode(String.self, forKey: .requirementsRu)
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(platform, forKey: .platform)
        try container.encode(releasedAt, forKey: .releasedAt)
        try container.encode(releasedAt, forKey: .requirementsEn)
        try container.encode(releasedAt, forKey: .requirementsRu)
    }

}

public struct Platform: Codable {

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

    public init(from decoder: Decoder) throws {
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

    public func encode(to encoder: Encoder) throws {
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

public struct Genres: Codable {

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

    public init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decode(Int.self, forKey: .id)
        name = try values.decode(String.self, forKey: .name)
        slug = try values.decode(String.self, forKey: .slug)
        gamesCount = try values.decode(Int.self, forKey: .gamesCount)
        imageBackground = try values.decode(String.self, forKey: .imageBackground)
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(name, forKey: .name)
        try container.encode(slug, forKey: .slug)
        try container.encode(gamesCount, forKey: .gamesCount)
        try container.encode(imageBackground, forKey: .imageBackground)
    }

}
