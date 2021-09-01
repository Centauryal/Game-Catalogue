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
    let seoTitle: String
    let seoDescription: String
    let seoKeywords: String
    let seoH1: String
    let noindex: Bool
    let nofollow: Bool
    let description: String
    let filters: Filters
    let nofollowCollections: [String]

    private enum CodingKeys: String, CodingKey {
        case count = "count"
        case next = "next"
        case previous = "previous"
        case results = "results"
        case seoTitle = "seo_title"
        case seoDescription = "seo_description"
        case seoKeywords = "seo_keywords"
        case seoH1 = "seo_h1"
        case noindex = "noindex"
        case nofollow = "nofollow"
        case description = "description"
        case filters = "filters"
        case nofollowCollections = "nofollow_collections"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        count = try values.decode(Int.self, forKey: .count)
        next = try values.decode(String.self, forKey: .next)
        previous = try? values.decode(String.self, forKey: .previous)
        results = try values.decode([ResultsGames].self, forKey: .results)
        seoTitle = try values.decode(String.self, forKey: .seoTitle)
        seoDescription = try values.decode(String.self, forKey: .seoDescription)
        seoKeywords = try values.decode(String.self, forKey: .seoKeywords)
        seoH1 = try values.decode(String.self, forKey: .seoH1)
        noindex = try values.decode(Bool.self, forKey: .noindex)
        nofollow = try values.decode(Bool.self, forKey: .nofollow)
        description = try values.decode(String.self, forKey: .description)
        filters = try values.decode(Filters.self, forKey: .filters)
        nofollowCollections = try values.decode([String].self, forKey: .nofollowCollections)
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(count, forKey: .count)
        try container.encode(next, forKey: .next)
        try container.encode(next, forKey: .previous)
        try container.encode(results, forKey: .results)
        try container.encode(seoTitle, forKey: .seoTitle)
        try container.encode(seoDescription, forKey: .seoDescription)
        try container.encode(seoKeywords, forKey: .seoKeywords)
        try container.encode(seoH1, forKey: .seoH1)
        try container.encode(noindex, forKey: .noindex)
        try container.encode(nofollow, forKey: .nofollow)
        try container.encode(description, forKey: .description)
        try container.encode(filters, forKey: .filters)
        try container.encode(nofollowCollections, forKey: .nofollowCollections)
    }

}

struct ResultsGames: Codable {

    let id: Int
    let slug: String
    let name: String
    let released: String
    let tba: Bool
    let backgroundImage: String
    let rating: Double
    let ratingTop: Int
    let ratings: [Ratings]
    let ratingsCount: Int
    let reviewsTextCount: Int
    let added: Int
    let addedByStatus: AddedByStatus
    let metacritic: Int
    let playtime: Int
    let suggestionsCount: Int
    let updated: String
    let userGame: String?
    let reviewsCount: Int
    let saturatedColor: String
    let dominantColor: String
    let platforms: [Platforms]
    let parentPlatforms: [ParentPlatforms]
    let genres: [Genres]
    let stores: [Stores]
    let clip: String?
    let tags: [Tags]
    let esrbRating: EsrbRating?
    let shortScreenshots: [ShortScreenshots]

    private enum CodingKeys: String, CodingKey {
        case id = "id"
        case slug = "slug"
        case name = "name"
        case released = "released"
        case tba = "tba"
        case backgroundImage = "background_image"
        case rating = "rating"
        case ratingTop = "rating_top"
        case ratings = "ratings"
        case ratingsCount = "ratings_count"
        case reviewsTextCount = "reviews_text_count"
        case added = "added"
        case addedByStatus = "added_by_status"
        case metacritic = "metacritic"
        case playtime = "playtime"
        case suggestionsCount = "suggestions_count"
        case updated = "updated"
        case userGame = "user_game"
        case reviewsCount = "reviews_count"
        case saturatedColor = "saturated_color"
        case dominantColor = "dominant_color"
        case platforms = "platforms"
        case parentPlatforms = "parent_platforms"
        case genres = "genres"
        case stores = "stores"
        case clip = "clip"
        case tags = "tags"
        case esrbRating = "esrb_rating"
        case shortScreenshots = "short_screenshots"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decode(Int.self, forKey: .id)
        slug = try values.decode(String.self, forKey: .slug)
        name = try values.decode(String.self, forKey: .name)
        released = try values.decode(String.self, forKey: .released)
        tba = try values.decode(Bool.self, forKey: .tba)
        backgroundImage = try values.decode(String.self, forKey: .backgroundImage)
        rating = try values.decode(Double.self, forKey: .rating)
        ratingTop = try values.decode(Int.self, forKey: .ratingTop)
        ratings = try values.decode([Ratings].self, forKey: .ratings)
        ratingsCount = try values.decode(Int.self, forKey: .ratingsCount)
        reviewsTextCount = try values.decode(Int.self, forKey: .reviewsTextCount)
        added = try values.decode(Int.self, forKey: .added)
        addedByStatus = try values.decode(AddedByStatus.self, forKey: .addedByStatus)
        metacritic = try values.decode(Int.self, forKey: .metacritic)
        playtime = try values.decode(Int.self, forKey: .playtime)
        suggestionsCount = try values.decode(Int.self, forKey: .suggestionsCount)
        updated = try values.decode(String.self, forKey: .updated)
        userGame = try? values.decode(String.self, forKey: .userGame)
        reviewsCount = try values.decode(Int.self, forKey: .reviewsCount)
        saturatedColor = try values.decode(String.self, forKey: .saturatedColor)
        dominantColor = try values.decode(String.self, forKey: .dominantColor)
        platforms = try values.decode([Platforms].self, forKey: .platforms)
        parentPlatforms = try values.decode([ParentPlatforms].self, forKey: .parentPlatforms)
        genres = try values.decode([Genres].self, forKey: .genres)
        stores = try values.decode([Stores].self, forKey: .stores)
        clip = try? values.decode(String.self, forKey: .clip)
        tags = try values.decode([Tags].self, forKey: .tags)
        esrbRating = try? values.decode(EsrbRating.self, forKey: .esrbRating)
        shortScreenshots = try values.decode([ShortScreenshots].self, forKey: .shortScreenshots)
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(slug, forKey: .slug)
        try container.encode(name, forKey: .name)
        try container.encode(released, forKey: .released)
        try container.encode(tba, forKey: .tba)
        try container.encode(backgroundImage, forKey: .backgroundImage)
        try container.encode(rating, forKey: .rating)
        try container.encode(ratingTop, forKey: .ratingTop)
        try container.encode(ratings, forKey: .ratings)
        try container.encode(ratingsCount, forKey: .ratingsCount)
        try container.encode(reviewsTextCount, forKey: .reviewsTextCount)
        try container.encode(added, forKey: .added)
        try container.encode(addedByStatus, forKey: .addedByStatus)
        try container.encode(metacritic, forKey: .metacritic)
        try container.encode(playtime, forKey: .playtime)
        try container.encode(suggestionsCount, forKey: .suggestionsCount)
        try container.encode(updated, forKey: .updated)
        try container.encode(updated, forKey: .userGame)
        try container.encode(reviewsCount, forKey: .reviewsCount)
        try container.encode(saturatedColor, forKey: .saturatedColor)
        try container.encode(dominantColor, forKey: .dominantColor)
        try container.encode(platforms, forKey: .platforms)
        try container.encode(parentPlatforms, forKey: .parentPlatforms)
        try container.encode(genres, forKey: .genres)
        try container.encode(stores, forKey: .stores)
        try container.encode(updated, forKey: .clip)
        try container.encode(tags, forKey: .tags)
        try container.encode(esrbRating, forKey: .esrbRating)
        try container.encode(shortScreenshots, forKey: .shortScreenshots)
    }

}

struct Ratings: Codable {

    let id: Int
    let title: String
    let count: Int
    let percent: Double

    private enum CodingKeys: String, CodingKey {
        case id = "id"
        case title = "title"
        case count = "count"
        case percent = "percent"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decode(Int.self, forKey: .id)
        title = try values.decode(String.self, forKey: .title)
        count = try values.decode(Int.self, forKey: .count)
        percent = try values.decode(Double.self, forKey: .percent)
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(title, forKey: .title)
        try container.encode(count, forKey: .count)
        try container.encode(percent, forKey: .percent)
    }

}

struct AddedByStatus: Codable {

    let yet: Int
    let owned: Int
    let beaten: Int
    let toplay: Int
    let dropped: Int
    let playing: Int

    private enum CodingKeys: String, CodingKey {
        case yet = "yet"
        case owned = "owned"
        case beaten = "beaten"
        case toplay = "toplay"
        case dropped = "dropped"
        case playing = "playing"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        yet = try values.decode(Int.self, forKey: .yet)
        owned = try values.decode(Int.self, forKey: .owned)
        beaten = try values.decode(Int.self, forKey: .beaten)
        toplay = try values.decode(Int.self, forKey: .toplay)
        dropped = try values.decode(Int.self, forKey: .dropped)
        playing = try values.decode(Int.self, forKey: .playing)
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(yet, forKey: .yet)
        try container.encode(owned, forKey: .owned)
        try container.encode(beaten, forKey: .beaten)
        try container.encode(toplay, forKey: .toplay)
        try container.encode(dropped, forKey: .dropped)
        try container.encode(playing, forKey: .playing)
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

struct ParentPlatforms: Codable {

    let platform: Platform

    private enum CodingKeys: String, CodingKey {
        case platform = "platform"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        platform = try values.decode(Platform.self, forKey: .platform)
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(platform, forKey: .platform)
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

struct Stores: Codable {

    let id: Int
    let store: Store

    private enum CodingKeys: String, CodingKey {
        case id = "id"
        case store = "store"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decode(Int.self, forKey: .id)
        store = try values.decode(Store.self, forKey: .store)
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(store, forKey: .store)
    }

}

struct Store: Codable {

    let id: Int
    let name: String
    let slug: String
    let domain: String
    let gamesCount: Int
    let imageBackground: String

    private enum CodingKeys: String, CodingKey {
        case id = "id"
        case name = "name"
        case slug = "slug"
        case domain = "domain"
        case gamesCount = "games_count"
        case imageBackground = "image_background"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decode(Int.self, forKey: .id)
        name = try values.decode(String.self, forKey: .name)
        slug = try values.decode(String.self, forKey: .slug)
        domain = try values.decode(String.self, forKey: .domain)
        gamesCount = try values.decode(Int.self, forKey: .gamesCount)
        imageBackground = try values.decode(String.self, forKey: .imageBackground)
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(name, forKey: .name)
        try container.encode(slug, forKey: .slug)
        try container.encode(domain, forKey: .domain)
        try container.encode(gamesCount, forKey: .gamesCount)
        try container.encode(imageBackground, forKey: .imageBackground)
    }

}

struct Tags: Codable {

    let id: Int
    let name: String
    let slug: String
    let language: String
    let gamesCount: Int
    let imageBackground: String

    private enum CodingKeys: String, CodingKey {
        case id = "id"
        case name = "name"
        case slug = "slug"
        case language = "language"
        case gamesCount = "games_count"
        case imageBackground = "image_background"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decode(Int.self, forKey: .id)
        name = try values.decode(String.self, forKey: .name)
        slug = try values.decode(String.self, forKey: .slug)
        language = try values.decode(String.self, forKey: .language)
        gamesCount = try values.decode(Int.self, forKey: .gamesCount)
        imageBackground = try values.decode(String.self, forKey: .imageBackground)
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(name, forKey: .name)
        try container.encode(slug, forKey: .slug)
        try container.encode(language, forKey: .language)
        try container.encode(gamesCount, forKey: .gamesCount)
        try container.encode(imageBackground, forKey: .imageBackground)
    }

}

struct EsrbRating: Codable {

    let id: Int
    let name: String
    let slug: String

    private enum CodingKeys: String, CodingKey {
        case id = "id"
        case name = "name"
        case slug = "slug"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decode(Int.self, forKey: .id)
        name = try values.decode(String.self, forKey: .name)
        slug = try values.decode(String.self, forKey: .slug)
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(name, forKey: .name)
        try container.encode(slug, forKey: .slug)
    }

}

struct ShortScreenshots: Codable {

    let id: Int
    let image: String

    private enum CodingKeys: String, CodingKey {
        case id = "id"
        case image = "image"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decode(Int.self, forKey: .id)
        image = try values.decode(String.self, forKey: .image)
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(image, forKey: .image)
    }

}

struct Filters: Codable {

    let years: [Years]?

    private enum CodingKeys: String, CodingKey {
        case years = "years"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        years = try? values.decode([Years].self, forKey: .years)
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(years, forKey: .years)
    }

}

struct Years: Codable {

    let from: Int
    let to: Int
    let filter: String
    let decade: Int
    let years: [Years]
    let nofollow: Bool
    let count: Int

    private enum CodingKeys: String, CodingKey {
        case from = "from"
        case to = "to"
        case filter = "filter"
        case decade = "decade"
        case years = "years"
        case nofollow = "nofollow"
        case count = "count"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        from = try values.decode(Int.self, forKey: .from)
        to = try values.decode(Int.self, forKey: .to)
        filter = try values.decode(String.self, forKey: .filter)
        decade = try values.decode(Int.self, forKey: .decade)
        years = try values.decode([Years].self, forKey: .years)
        nofollow = try values.decode(Bool.self, forKey: .nofollow)
        count = try values.decode(Int.self, forKey: .count)
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(from, forKey: .from)
        try container.encode(to, forKey: .to)
        try container.encode(filter, forKey: .filter)
        try container.encode(decade, forKey: .decade)
        try container.encode(years, forKey: .years)
        try container.encode(nofollow, forKey: .nofollow)
        try container.encode(count, forKey: .count)
    }

}
