//
//  FavoriteInteractor.swift
//  gamescatalogue
//
//  Created by Alfa Centaury on 06/11/21.
//

import Foundation

protocol FavoriteUseCase {
    func getAllFavorite(completion: @escaping(Result<[GameDB], Error>) -> Void)
    
    func deleteFavorite(_ id: Int, completion: @escaping(Result<Bool, Error>) -> Void)
}

class FavoriteInteractor: FavoriteUseCase {
    private let repository: GamesCatalogueRepositoryProtocol
    
    required init(repository: GamesCatalogueRepositoryProtocol) {
        self.repository = repository
    }
    
    func getAllFavorite(completion: @escaping (Result<[GameDB], Error>) -> Void) {
        repository.getAllFavorite { result in
            completion(result)
        }
    }
    
    func deleteFavorite(_ id: Int, completion: @escaping (Result<Bool, Error>) -> Void) {
        repository.deleteFavorite(id) { result in
            completion(result)
        }
    }
}
