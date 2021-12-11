//
//  Injection.swift
//  gamescatalogue
//
//  Created by Alfa Centaury on 05/11/21.
//

import Foundation
import Core
import Games

final class Injection: NSObject {
    func provideHome<U: UseCase>() -> U
    where U.Request == Any, U.Response == [Game] {
        let remote = GetGamesRemoteData(endpoint: Endpoints.Gets.listGames.urlEndpoint)
        let mapper = GameResultMapper()
        
        let repository = GamesRepository(remoteDataSource: remote, mapper: mapper)
        
        return Interactor(repository: repository) as! U
    }
    
    func provideDetail<U: UseCase>() -> U
    where U.Request == String, U.Response == Detail {
        let remote = GetGameDetailRemoteData(endpoint: Endpoints.Gets.detailGame.urlEndpoint)
        let mapper = DetailResultMapper()
        
        let repository = GamesDetailRepository(remoteDataSource: remote, mapper: mapper)
        
        return Interactor(repository: repository) as! U
    }
//
//    func provideFavorite() -> FavoriteUseCase {
//        let repository = provideRepository()
//        return FavoriteInteractor(repository: repository)
//    }
//
//    func provideAccount() -> AccountUseCase {
//        let repository = provideRepository()
//        return AccountInteractor(repository: repository)
//    }
}
