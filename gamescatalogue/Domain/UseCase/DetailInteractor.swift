//
//  DetailInteractor.swift
//  gamescatalogue
//
//  Created by Alfa Centaury on 06/11/21.
//

import Foundation

protocol DetailUseCase {
    func getDetailGame(completion: @escaping (Result<Detail, Error>) -> Void)
    
    func getFavorite(completion: @escaping(Result<GameDB, Error>) -> Void)
    
    func setFavorite(_ gameEntity: GameDB, completion: @escaping(Result<Bool, Error>) -> Void)
    
    func deleteFavorite(completion: @escaping(Result<Bool, Error>) -> Void)
}

class DetailInteractor: DetailUseCase {
    private let repository: GamesCatalogueRepositoryProtocol
    private let id: String
    
    required init(idDetail id: String, repository: GamesCatalogueRepositoryProtocol) {
        self.repository = repository
        self.id = id
    }
    
    func getDetailGame(completion: @escaping (Result<Detail, Error>) -> Void) {
        repository.getDetailGame(idDetail: id) { result in
            completion(result)
        }
    }
    
    func getFavorite(completion: @escaping (Result<GameDB, Error>) -> Void) {
        repository.getFavorite(Int(id)!) { result in
            completion(result)
        }
    }
    
    func setFavorite(_ gameEntity: GameDB, completion: @escaping (Result<Bool, Error>) -> Void) {
        repository.setFavorite(gameEntity) { result in
            completion(result)
        }
    }
    
    func deleteFavorite(completion: @escaping (Result<Bool, Error>) -> Void) {
        repository.deleteFavorite(Int(id)!) { result in
            completion(result)
        }
    }
}
