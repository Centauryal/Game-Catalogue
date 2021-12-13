//
//  GameEntityMapper.swift
//  gamescatalogue
//
//  Created by Alfa Centaury on 05/11/21.
//

import Foundation

final class GameEntityMapper {
//    static func transformGamesEntity(input entityGame: [GameEntity]) -> [GameDB] {
//        return entityGame.map { entity in
//            return GameDB(
//                id: entity.id ?? 0,
//                name: entity.name ?? "Unknown",
//                image: entity.image ?? "Unknown",
//                imageBackground: entity.imageBackground ?? "Unknown",
//                desc: entity.desc ?? "Unknown",
//                releaseDate: entity.releaseDate ?? "Unknown",
//                genre: entity.genre ?? "Unknown",
//                platform: entity.platform ?? "Unknown",
//                publisher: entity.publisher ?? "Unknown",
//                rating: entity.rating ?? 0.0
//            )
//        }
//    }
//    
//    static func transformDetailEntity(input entityGame: GameEntity) -> GameDB {
//        return GameDB(
//            id: entityGame.id ?? 0,
//            name: entityGame.name ?? "Unknown",
//            image: entityGame.image ?? "Unknown",
//            imageBackground: entityGame.imageBackground ?? "Unknown",
//            desc: entityGame.desc ?? "Unknown",
//            releaseDate: entityGame.releaseDate ?? "Unknown",
//            genre: entityGame.genre ?? "Unknown",
//            platform: entityGame.platform ?? "Unknown",
//            publisher: entityGame.publisher ?? "Unknown",
//            rating: entityGame.rating ?? 0.0
//        )
//    }
//    
//    static func transformGameDB(input entityGame: GameDB) -> GameEntity {
//        return GameEntity(
//            id: entityGame.id,
//            name: entityGame.name,
//            image: entityGame.image,
//            imageBackground: entityGame.imageBackground,
//            desc: entityGame.desc,
//            releaseDate: entityGame.releaseDate,
//            genre: entityGame.genre,
//            platform: entityGame.platform,
//            publisher: entityGame.publisher,
//            rating: entityGame.rating
//        )
//    }
    
    static func transformAccountEntity(input entityAccount: AccountEntity) -> Account {
        return Account(
            name: entityAccount.name,
            image: entityAccount.image,
            desc: entityAccount.desc
        )
    }
    
    static func transformAccount(input account: Account) -> AccountEntity {
        return AccountEntity(
            name: account.name,
            image: account.image,
            desc: account.desc
        )
    }
}
