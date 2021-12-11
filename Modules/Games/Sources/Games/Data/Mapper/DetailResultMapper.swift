//
//  File.swift
//  
//
//  Created by Alfa Centaury on 07/12/21.
//

import Core

public struct DetailResultMapper: Mapper {
    public typealias Response = DetailGameResponse
    public typealias Domain = Detail
    
    public init() {}
    
    public func transfomResponseToDomain(response: DetailGameResponse) -> Detail {
        return Detail(
            id: response.id,
            name: response.name,
            description: response.description,
            released: response.released,
            backgroundImage: response.backgroundImage,
            backgroundImageAdditional: response.backgroundImageAdditional ?? "Unknown",
            rating: response.rating,
            platforms: response.platforms.map { platform in
                platform.platform.name
            },
            genres: response.genres.map { genre in
                genre.name
            },
            publishers: response.publishers.map { publisher in
                publisher.name
            }
        )
    }
}
