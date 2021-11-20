//
//  GamesCatalogueRepository.swift
//  gamescatalogue
//
//  Created by Alfa Centaury on 05/11/21.
//

import Foundation

protocol GamesCatalogueRepositoryProtocol {
    func getListGames(completion: @escaping (Result<[Game], Error>) -> Void)
    
    func getDetailGame(idDetail id: String, completion: @escaping (Result<Detail, Error>) -> Void)
    
    func getAllFavorite(completion: @escaping(Result<[GameDB], Error>) -> Void)
    
    func getFavorite(_ id: Int, completion: @escaping(Result<GameDB, Error>) -> Void)
    
    func setFavorite(_ gameEntity: GameDB, completion: @escaping(Result<Bool, Error>) -> Void)
    
    func deleteAllFavorite(completion: @escaping(Result<Bool, Error>) -> Void)
    
    func deleteFavorite(_ id: Int, completion: @escaping(Result<Bool, Error>) -> Void)
    
    func loadUserAccount(completion: @escaping(Result<Account, LocaleError>) -> Void)
    
    func addUserAccount(_ accountEntity: Account, completion: @escaping(Result<Bool, LocaleError>) -> Void)
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
    func getListGames(completion: @escaping (Result<[Game], Error>) -> Void) {
        self.remote.getListGames { remoteResponses in
            switch remoteResponses {
            case .success(let resultGame):
                let resultList = GameResultMapper.transformGameResult(input: resultGame)
                completion(.success(resultList))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func getDetailGame(idDetail id: String, completion: @escaping (Result<Detail, Error>) -> Void) {
        self.remote.getDetailGame(idDetail: id) { detailResponse in
            switch detailResponse {
            case .success(let detailGame):
                let resultDetail = GameResultMapper.transformDetailResult(input: detailGame)
                completion(.success(resultDetail))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func getAllFavorite(completion: @escaping (Result<[GameDB], Error>) -> Void) {
        self.locale.getAllFavorite { favorites in
            switch favorites {
            case .success(let favorite):
                let favoriteDB = GameEntityMapper.transformGamesEntity(input: favorite)
                completion(.success(favoriteDB))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func getFavorite(_ id: Int, completion: @escaping (Result<GameDB, Error>) -> Void) {
        self.locale.getFavorite(id) { favorite in
            switch favorite {
            case .success(let detailFavorite):
                let favoriteDB = GameEntityMapper.transformDetailEntity(input: detailFavorite)
                completion(.success(favoriteDB))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func setFavorite(_ gameEntity: GameDB, completion: @escaping (Result<Bool, Error>) -> Void) {
        self.locale.setFavorite(GameEntityMapper.transformGameDB(input: gameEntity)) { favorite in
            switch favorite {
            case .success(_):
                completion(.success(true))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func deleteAllFavorite(completion: @escaping (Result<Bool, Error>) -> Void) {
        self.locale.deleteAllFavorite { favorite in
            switch favorite {
            case .success(_):
                completion(.success(true))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func deleteFavorite(_ id: Int, completion: @escaping (Result<Bool, Error>) -> Void) {
        self.locale.deleteFavorite(id) { favorite in
            switch favorite {
            case .success(_):
                completion(.success(true))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func loadUserAccount(completion: @escaping (Result<Account, LocaleError>) -> Void) {
        self.locale.loadUserAccount { account in
            switch account {
            case .success(let user):
                let userAccount = GameEntityMapper.transformAccountEntity(input: user)
                completion(.success(userAccount))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func addUserAccount(_ accountEntity: Account, completion: @escaping (Result<Bool, LocaleError>) -> Void) {
        self.locale.addUserAccount(GameEntityMapper.transformAccount(input: accountEntity)) { account in
            switch account {
            case .success(_):
                completion(.success(true))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
