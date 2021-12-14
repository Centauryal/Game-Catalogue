//
//  File.swift
//  
//
//  Created by Alfa Centaury on 11/12/21.
//

import Core
import Common

public struct DetailEntityMapper: LocaleMapper {
    public typealias Entity = FavoriteModuleEntity
    public typealias Domain = GameDB
    
    public init() {}
    
    public func transformEntityToDomain(entity: FavoriteModuleEntity) -> GameDB {
        return GameDB(
            id: entity.id ?? 0,
            name: entity.name ?? "text_unknown".localized(),
            image: entity.image ?? "text_unknown".localized(),
            imageBackground: entity.imageBackground ?? "text_unknown".localized(),
            desc: entity.desc ?? "text_unknown".localized(),
            releaseDate: entity.releaseDate ?? "text_unknown".localized(),
            genre: entity.genre ?? "text_unknown".localized(),
            platform: entity.platform ?? "text_unknown".localized(),
            publisher: entity.publisher ?? "text_unknown".localized(),
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
