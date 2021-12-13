//
//  Injection.swift
//  gamescatalogue
//
//  Created by Alfa Centaury on 05/11/21.
//

import Foundation
import Core
import Games
import Favorite
import Account

final class Injection: NSObject {
    func provideHome<U: UseCase>() -> U
    where U.Request == Any, U.Response == [Game] {
        let remote = GetGamesRemoteData(endpoint: Endpoints.Gets.listGames.urlEndpoint)
        let mapper = GameResultMapper()
        
        let repository = GamesRepository(remoteDataSource: remote, mapper: mapper)
        
        guard let interactor = Interactor(repository: repository) as? U else { fatalError("Check Injection") }
        return interactor
    }
    
    func provideDetail<U: UseCase>() -> U
    where U.Request == String, U.Response == Detail {
        let remote = GetGameDetailRemoteData(endpoint: Endpoints.Gets.detailGame.urlEndpoint)
        let mapper = DetailResultMapper()
        
        let repository = GamesDetailRepository(remoteDataSource: remote, mapper: mapper)
        
        guard let interactor = Interactor(repository: repository) as? U else { fatalError("Check Injection") }
        return interactor
    }

    func provideFavorite<U: UseCase>() -> U
    where U.Request == Any, U.Response == [GameDB] {
        let locale = GetFavoriteLocaleData(persistenceContainer: ModuleProvider.sharedManager.persistanContainer)
        let mapper = FavoriteEntityMapper()
        
        let repository = FavoriteRepository(localeDataSource: locale, mapper: mapper)
        
        guard let interactor = Interactor(repository: repository) as? U else { fatalError("Check Injection") }
        return interactor
    }
    
    func provideDeleteFavorite<U: UseCase>() -> U
    where U.Request == Int, U.Response == Bool {
        let locale = GetFavoriteLocaleData(persistenceContainer: ModuleProvider.sharedManager.persistanContainer)
        
        let repository = FavoriteDeleteByIdRepository(localeDataSource: locale)
        
        guard let interactor = Interactor(repository: repository) as? U else { fatalError("Check Injection") }
        return interactor
    }
    
    func provideGetFavorite<U: UseCase>() -> U
    where U.Request == Int, U.Response == GameDB {
        let locale = GetFavoriteLocaleData(persistenceContainer: ModuleProvider.sharedManager.persistanContainer)
        let mapper = DetailEntityMapper()
        
        let repository = FavoriteGetByIdRepository(localeDataSource: locale, mapper: mapper)
        
        guard let interactor = Interactor(repository: repository) as? U else { fatalError("Check Injection") }
        return interactor
    }
    
    func provideSetFavorite<U: UseCase>() -> U
    where U.Request == GameDB, U.Response == Bool {
        let locale = GetFavoriteLocaleData(persistenceContainer: ModuleProvider.sharedManager.persistanContainer)
        let mapper = DetailEntityMapper()
        
        let repository = FavoriteSetRepository(localeDataSource: locale, mapper: mapper)
        
        guard let interactor = Interactor(repository: repository) as? U else { fatalError("Check Injection") }
        return interactor
    }

    func provideGetAccount<U: UseCase>() -> U
    where U.Request == Any, U.Response == Account {
        let locale = GetAccountLocaleData()
        let mapper = AccountEntityMapper()
        
        let repository = AccountGetRepository(localDataSource: locale, mapper: mapper)
        
        guard let interactor = Interactor(repository: repository) as? U else { fatalError("Check Injection") }
        return interactor
    }
    
    func provideSetAccount<U: UseCase>() -> U
    where U.Request == Account, U.Response == Bool {
        let locale = GetAccountLocaleData()
        let mapper = AccountEntityMapper()
        
        let repository = AccountSetRepository(localDataSource: locale, mapper: mapper)
        
        guard let interactor = Interactor(repository: repository) as? U else { fatalError("Check Injection") }
        return interactor
    }
}
