//
//  GamesCatalogueRepository.swift
//  gamescatalogue
//
//  Created by Alfa Centaury on 05/11/21.
//

import Foundation
import Combine

protocol GamesCatalogueRepositoryProtocol {
    func getListGames() -> AnyPublisher<[Game], Error>
    
    func getDetailGame(idDetail id: String) -> AnyPublisher<Detail, Error>
    
    func getAllFavorite() -> AnyPublisher<[GameDB], Error>
    
    func getFavorite(_ id: Int) -> AnyPublisher<GameDB, Error>
    
    func setFavorite(_ gameEntity: GameDB) -> AnyPublisher<Bool, Error>
    
    func deleteAllFavorite() -> AnyPublisher<Bool, Error>
    
    func deleteFavorite(_ id: Int) -> AnyPublisher<Bool, Error>
    
    func loadUserAccount() -> AnyPublisher<Account, Error>
    
    func addUserAccount(_ accountEntity: Account) -> AnyPublisher<Bool, Error>
}

final class GamesCatalogueRepository: NSObject {
    typealias GamesCatalogueInstance = (RemoteDataSource, LocaleDataSource) -> GamesCatalogueRepository
    
    fileprivate let remote: RemoteDataSource
    fileprivate let locale: LocaleDataSource
    
    private init(remote: RemoteDataSource, locale: LocaleDataSource) {
        self.remote = remote
        self.locale = locale
    }
    
    static let sharedInstance: GamesCatalogueInstance = { remoteRepo, localeRepo in
        return GamesCatalogueRepository(remote: remoteRepo, locale: localeRepo)
    }
}

extension GamesCatalogueRepository: GamesCatalogueRepositoryProtocol {
    func getListGames() -> AnyPublisher<[Game], Error> {
        self.remote.getListGames()
            .map { GameResultMapper.transformGameResult(input: $0) }
            .eraseToAnyPublisher()
    }
    
    func getDetailGame(idDetail id: String) -> AnyPublisher<Detail, Error> {
        self.remote.getDetailGame(idDetail: id)
            .map { GameResultMapper.transformDetailResult(input: $0) }
            .eraseToAnyPublisher()
    }
    
    func getAllFavorite() -> AnyPublisher<[GameDB], Error> {
        self.locale.getAllFavorite()
            .map { GameEntityMapper.transformGamesEntity(input: $0) }
            .eraseToAnyPublisher()
    }
    
    func getFavorite(_ id: Int) -> AnyPublisher<GameDB, Error> {
        self.locale.getFavorite(id)
            .map { GameEntityMapper.transformDetailEntity(input: $0) }
            .eraseToAnyPublisher()
    }
    
    func setFavorite(_ gameEntity: GameDB) -> AnyPublisher<Bool, Error> {
        self.locale.setFavorite(GameEntityMapper.transformGameDB(input: gameEntity))
    }
    
    func deleteAllFavorite() -> AnyPublisher<Bool, Error> {
        self.locale.deleteAllFavorite()
    }
    
    func deleteFavorite(_ id: Int) -> AnyPublisher<Bool, Error> {
        self.locale.deleteFavorite(id)
    }
    
    func loadUserAccount() -> AnyPublisher<Account, Error> {
        self.locale.loadUserAccount()
            .map { GameEntityMapper.transformAccountEntity(input: $0) }
            .eraseToAnyPublisher()
    }
    
    func addUserAccount(_ accountEntity: Account) -> AnyPublisher<Bool, Error> {
        self.locale.addUserAccount(GameEntityMapper.transformAccount(input: accountEntity))
    }
}
