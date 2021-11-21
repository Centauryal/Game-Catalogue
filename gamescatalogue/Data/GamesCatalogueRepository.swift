//
//  GamesCatalogueRepository.swift
//  gamescatalogue
//
//  Created by Alfa Centaury on 05/11/21.
//

import Foundation
import RxSwift

protocol GamesCatalogueRepositoryProtocol {
    func getListGames() -> Observable<[Game]>
    
    func getDetailGame(idDetail id: String) -> Observable<Detail>
    
    func getAllFavorite() -> Observable<[GameDB]>
    
    func getFavorite(_ id: Int) -> Observable<GameDB>
    
    func setFavorite(_ gameEntity: GameDB) -> Observable<Bool>
    
    func deleteAllFavorite() -> Observable<Bool>
    
    func deleteFavorite(_ id: Int) -> Observable<Bool>
    
    func loadUserAccount() -> Observable<Account>
    
    func addUserAccount(_ accountEntity: Account) -> Observable<Bool>
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
    func getListGames() -> Observable<[Game]> {
        self.remote.getListGames()
            .map { GameResultMapper.transformGameResult(input: $0) }
    }
    
    func getDetailGame(idDetail id: String) -> Observable<Detail> {
        self.remote.getDetailGame(idDetail: id)
            .map { GameResultMapper.transformDetailResult(input: $0) }
    }
    
    func getAllFavorite() -> Observable<[GameDB]> {
        self.locale.getAllFavorite()
            .map { GameEntityMapper.transformGamesEntity(input: $0) }
    }
    
    func getFavorite(_ id: Int) -> Observable<GameDB> {
        self.locale.getFavorite(id)
            .map { GameEntityMapper.transformDetailEntity(input: $0) }
    }
    
    func setFavorite(_ gameEntity: GameDB) -> Observable<Bool> {
        self.locale.setFavorite(GameEntityMapper.transformGameDB(input: gameEntity))
    }
    
    func deleteAllFavorite() -> Observable<Bool> {
        self.locale.deleteAllFavorite()
    }
    
    func deleteFavorite(_ id: Int) -> Observable<Bool> {
        self.locale.deleteFavorite(id)
    }
    
    func loadUserAccount() -> Observable<Account> {
        self.locale.loadUserAccount()
            .map { GameEntityMapper.transformAccountEntity(input: $0) }
    }
    
    func addUserAccount(_ accountEntity: Account) -> Observable<Bool> {
        self.locale.addUserAccount(GameEntityMapper.transformAccount(input: accountEntity))
    }
}
