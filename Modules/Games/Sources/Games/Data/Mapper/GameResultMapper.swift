//
//  File.swift
//  
//
//  Created by Alfa Centaury on 07/12/21.
//

import Core

public struct GameResultMapper: Mapper {
    public typealias Response = [ResultsGames]
    public typealias Domain = [Game]
    
    public init() {}
    
    public func transfomResponseToDomain(response: [ResultsGames]) -> [Game] {
        return response.map { result in
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
}
