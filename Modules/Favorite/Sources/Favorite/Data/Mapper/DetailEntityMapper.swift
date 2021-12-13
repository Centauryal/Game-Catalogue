//
//  File.swift
//  
//
//  Created by Alfa Centaury on 11/12/21.
//

import Core

public struct DetailEntityMapper: LocaleMapper {
    public typealias Entity = FavoriteModuleEntity
    public typealias Domain = GameDB
    
    public init() {}
    
    public func transformEntityToDomain(entity: FavoriteModuleEntity) -> GameDB {
        return GameDB(
            id: entity.id ?? 0,
            name: entity.name ?? "Unknown",
            image: entity.image ?? "Unknown",
            imageBackground: entity.imageBackground ?? "Unknown",
            desc: entity.desc ?? "Unknown",
            releaseDate: entity.releaseDate ?? "Unknown",
            genre: entity.genre ?? "Unknown",
            platform: entity.platform ?? "Unknown",
            publisher: entity.publisher ?? "Unknown",
            rating: entity.rating ?? 0.0
        )
    }
    
    public func transfomDomainToEntity(domain: GameDB) -> FavoriteModuleEntity {
        return FavoriteModuleEntity(
            id: domain.id,
            name: domain.name,
            image: domain.image,
            imageBackground: domain.imageBackground,
            desc: domain.desc,
            releaseDate: domain.releaseDate,
            genre: domain.genre,
            platform: domain.platform,
            publisher: domain.publisher,
            rating: domain.rating
        )
    }
}
