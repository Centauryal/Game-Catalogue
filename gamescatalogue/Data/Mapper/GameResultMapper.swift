//
//  GameResultMapper.swift
//  gamescatalogue
//
//  Created by Alfa Centaury on 05/11/21.
//

import Foundation

final class GameResultMapper {
    static func transformGameResult(input resultGame: [ResultsGames]) -> [Game] {
        return resultGame.map { result in
            return Game(
                id: result.id,
                name: result.name,
                released: result.released,
                backgroundImage: result.backgroundImage,
                rating: result.rating,
                platforms: result.platforms.map { platform in
                    platform.platform.name
                },
                genres: result.genres.map { genre in
                    genre.name
                }
            )
        }
    }
    
    static func transformDetailResult(input detailGame: DetailGameResponse) -> Detail {
        return Detail(
            id: detailGame.id,
            name: detailGame.name,
            description: detailGame.description,
            released: detailGame.released,
            backgroundImage: detailGame.backgroundImage,
            backgroundImageAdditional: detailGame.backgroundImageAdditional ?? "Unknown",
            rating: detailGame.rating,
            platforms: detailGame.platforms.map { platform in
                platform.platform.name
            },
            genres: detailGame.genres.map { genre in
                genre.name
            },
            publishers: detailGame.publishers.map { publisher in
                publisher.name
            }
        )
    }
}
