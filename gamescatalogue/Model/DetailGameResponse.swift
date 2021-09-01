//
//  DetailGameResponse.swift
//  gamescatalogue
//
//  Created by Alfa Centaury on 31/08/21.
//

import Foundation

struct DetailGameResponse: Codable {

    let id: Int
    let slug: String
    let name: String
    let nameOriginal: String
    let description: String
    let metacritic: Int
    let metacriticPlatforms: [MetacriticPlatforms]?
    let released: String
    let tba: Bool
    let updated: String
    let backgroundImage: String
    let backgroundImageAdditional: String
    let website: String
    let rating: Double
    let ratingTop: Int
    let ratings: [Ratings]
    let added: Int
    let addedByStatus: AddedByStatus
    let playtime: Int
    let screenshotsCount: Int
    let moviesCount: Int
    let creatorsCount: Int
    let achievementsCount: Int
    let parentAchievementsCount: Int
    let redditUrl: String
    let redditName: String
    let redditDescription: String
    let redditLogo: String
    let redditCount: Int
    let twitchCount: Int
    let youtubeCount: Int
    let reviewsTextCount: Int
    let ratingsCount: Int
    let suggestionsCount: Int
    let alternativeNames: [String]
    let metacriticUrl: String
    let parentsCount: Int
    let additionsCount: Int
    let gameSeriesCount: Int
    let reviewsCount: Int
    let saturatedColor: String
    let dominantColor: String
    let parentPlatforms: [ParentPlatforms]
    let platforms: [Platforms]
    let stores: [Stores]
    let developers: [Developers]
    let genres: [Genres]
    let tags: [Tags]
    let publishers: [Publishers]
    let esrbRating: EsrbRating
    let descriptionRaw: String

    private enum CodingKeys: String, CodingKey {
        case id = "id"
        case slug = "slug"
        case name = "name"
        case nameOriginal = "name_original"
        case description = "description"
        case metacritic = "metacritic"
        case metacriticPlatforms = "metacritic_platforms"
        case released = "released"
        case tba = "tba"
        case updated = "updated"
        case backgroundImage = "background_image"
        case backgroundImageAdditional = "background_image_additional"
        case website = "website"
        case rating = "rating"
        case ratingTop = "rating_top"
        case ratings = "ratings"
        case added = "added"
        case addedByStatus = "added_by_status"
        case playtime = "playtime"
        case screenshotsCount = "screenshots_count"
        case moviesCount = "movies_count"
        case creatorsCount = "creators_count"
        case achievementsCount = "achievements_count"
        case parentAchievementsCount = "parent_achievements_count"
        case redditUrl = "reddit_url"
        case redditName = "reddit_name"
        case redditDescription = "reddit_description"
        case redditLogo = "reddit_logo"
        case redditCount = "reddit_count"
        case twitchCount = "twitch_count"
        case youtubeCount = "youtube_count"
        case reviewsTextCount = "reviews_text_count"
        case ratingsCount = "ratings_count"
        case suggestionsCount = "suggestions_count"
        case alternativeNames = "alternative_names"
        case metacriticUrl = "metacritic_url"
        case parentsCount = "parents_count"
        case additionsCount = "additions_count"
        case gameSeriesCount = "game_series_count"
        case reviewsCount = "reviews_count"
        case saturatedColor = "saturated_color"
        case dominantColor = "dominant_color"
        case parentPlatforms = "parent_platforms"
        case platforms = "platforms"
        case stores = "stores"
        case developers = "developers"
        case genres = "genres"
        case tags = "tags"
        case publishers = "publishers"
        case esrbRating = "esrb_rating"
        case descriptionRaw = "description_raw"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decode(Int.self, forKey: .id)
        slug = try values.decode(String.self, forKey: .slug)
        name = try values.decode(String.self, forKey: .name)
        nameOriginal = try values.decode(String.self, forKey: .nameOriginal)
        description = try values.decode(String.self, forKey: .description)
        metacritic = try values.decode(Int.self, forKey: .metacritic)
        metacriticPlatforms = try? values.decode([MetacriticPlatforms].self, forKey: .metacriticPlatforms)
        released = try values.decode(String.self, forKey: .released)
        tba = try values.decode(Bool.self, forKey: .tba)
        updated = try values.decode(String.self, forKey: .updated)
        backgroundImage = try values.decode(String.self, forKey: .backgroundImage)
        backgroundImageAdditional = try values.decode(String.self, forKey: .backgroundImageAdditional)
        website = try values.decode(String.self, forKey: .website)
        rating = try values.decode(Double.self, forKey: .rating)
        ratingTop = try values.decode(Int.self, forKey: .ratingTop)
        ratings = try values.decode([Ratings].self, forKey: .ratings)
        added = try values.decode(Int.self, forKey: .added)
        addedByStatus = try values.decode(AddedByStatus.self, forKey: .addedByStatus)
        playtime = try values.decode(Int.self, forKey: .playtime)
        screenshotsCount = try values.decode(Int.self, forKey: .screenshotsCount)
        moviesCount = try values.decode(Int.self, forKey: .moviesCount)
        creatorsCount = try values.decode(Int.self, forKey: .creatorsCount)
        achievementsCount = try values.decode(Int.self, forKey: .achievementsCount)
        parentAchievementsCount = try values.decode(Int.self, forKey: .parentAchievementsCount)
        redditUrl = try values.decode(String.self, forKey: .redditUrl)
        redditName = try values.decode(String.self, forKey: .redditName)
        redditDescription = try values.decode(String.self, forKey: .redditDescription)
        redditLogo = try values.decode(String.self, forKey: .redditLogo)
        redditCount = try values.decode(Int.self, forKey: .redditCount)
        twitchCount = try values.decode(Int.self, forKey: .twitchCount)
        youtubeCount = try values.decode(Int.self, forKey: .youtubeCount)
        reviewsTextCount = try values.decode(Int.self, forKey: .reviewsTextCount)
        ratingsCount = try values.decode(Int.self, forKey: .ratingsCount)
        suggestionsCount = try values.decode(Int.self, forKey: .suggestionsCount)
        alternativeNames = try values.decode([String].self, forKey: .alternativeNames)
        metacriticUrl = try values.decode(String.self, forKey: .metacriticUrl)
        parentsCount = try values.decode(Int.self, forKey: .parentsCount)
        additionsCount = try values.decode(Int.self, forKey: .additionsCount)
        gameSeriesCount = try values.decode(Int.self, forKey: .gameSeriesCount)
        reviewsCount = try values.decode(Int.self, forKey: .reviewsCount)
        saturatedColor = try values.decode(String.self, forKey: .saturatedColor)
        dominantColor = try values.decode(String.self, forKey: .dominantColor)
        parentPlatforms = try values.decode([ParentPlatforms].self, forKey: .parentPlatforms)
        platforms = try values.decode([Platforms].self, forKey: .platforms)
        stores = try values.decode([Stores].self, forKey: .stores)
        developers = try values.decode([Developers].self, forKey: .developers)
        genres = try values.decode([Genres].self, forKey: .genres)
        tags = try values.decode([Tags].self, forKey: .tags)
        publishers = try values.decode([Publishers].self, forKey: .publishers)
        esrbRating = try values.decode(EsrbRating.self, forKey: .esrbRating)
        descriptionRaw = try values.decode(String.self, forKey: .descriptionRaw)
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(slug, forKey: .slug)
        try container.encode(name, forKey: .name)
        try container.encode(nameOriginal, forKey: .nameOriginal)
        try container.encode(description, forKey: .description)
        try container.encode(metacritic, forKey: .metacritic)
        try container.encode(metacriticPlatforms, forKey: .metacriticPlatforms)
        try container.encode(released, forKey: .released)
        try container.encode(tba, forKey: .tba)
        try container.encode(updated, forKey: .updated)
        try container.encode(backgroundImage, forKey: .backgroundImage)
        try container.encode(backgroundImageAdditional, forKey: .backgroundImageAdditional)
        try container.encode(website, forKey: .website)
        try container.encode(rating, forKey: .rating)
        try container.encode(ratingTop, forKey: .ratingTop)
        try container.encode(ratings, forKey: .ratings)
        try container.encode(added, forKey: .added)
        try container.encode(addedByStatus, forKey: .addedByStatus)
        try container.encode(playtime, forKey: .playtime)
        try container.encode(screenshotsCount, forKey: .screenshotsCount)
        try container.encode(moviesCount, forKey: .moviesCount)
        try container.encode(creatorsCount, forKey: .creatorsCount)
        try container.encode(achievementsCount, forKey: .achievementsCount)
        try container.encode(parentAchievementsCount, forKey: .parentAchievementsCount)
        try container.encode(redditUrl, forKey: .redditUrl)
        try container.encode(redditName, forKey: .redditName)
        try container.encode(redditDescription, forKey: .redditDescription)
        try container.encode(redditLogo, forKey: .redditLogo)
        try container.encode(redditCount, forKey: .redditCount)
        try container.encode(twitchCount, forKey: .twitchCount)
        try container.encode(youtubeCount, forKey: .youtubeCount)
        try container.encode(reviewsTextCount, forKey: .reviewsTextCount)
        try container.encode(ratingsCount, forKey: .ratingsCount)
        try container.encode(suggestionsCount, forKey: .suggestionsCount)
        try container.encode(alternativeNames, forKey: .alternativeNames)
        try container.encode(metacriticUrl, forKey: .metacriticUrl)
        try container.encode(parentsCount, forKey: .parentsCount)
        try container.encode(additionsCount, forKey: .additionsCount)
        try container.encode(gameSeriesCount, forKey: .gameSeriesCount)
        try container.encode(reviewsCount, forKey: .reviewsCount)
        try container.encode(saturatedColor, forKey: .saturatedColor)
        try container.encode(dominantColor, forKey: .dominantColor)
        try container.encode(parentPlatforms, forKey: .parentPlatforms)
        try container.encode(platforms, forKey: .platforms)
        try container.encode(stores, forKey: .stores)
        try container.encode(developers, forKey: .developers)
        try container.encode(genres, forKey: .genres)
        try container.encode(tags, forKey: .tags)
        try container.encode(publishers, forKey: .publishers)
        try container.encode(esrbRating, forKey: .esrbRating)
        try container.encode(descriptionRaw, forKey: .descriptionRaw)
    }

}

struct MetacriticPlatforms: Codable {

    let metascore: Int
    let url: String
    let platform: Platform

    private enum CodingKeys: String, CodingKey {
        case metascore = "metascore"
        case url = "url"
        case platform = "platform"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        metascore = try values.decode(Int.self, forKey: .metascore)
        url = try values.decode(String.self, forKey: .url)
        platform = try values.decode(Platform.self, forKey: .platform)
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(metascore, forKey: .metascore)
        try container.encode(url, forKey: .url)
        try container.encode(platform, forKey: .platform)
    }

}

struct Developers: Codable {

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


