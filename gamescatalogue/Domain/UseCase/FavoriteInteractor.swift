//
//  FavoriteInteractor.swift
//  gamescatalogue
//
//  Created by Alfa Centaury on 06/11/21.
//

import Foundation
import Combine

protocol FavoriteUseCase {
    func getAllFavorite() -> AnyPublisher<[GameDB], Error>
    
    func deleteFavorite(_ id: Int) -> AnyPublisher<Bool, Error>
}

class FavoriteInteractor: FavoriteUseCase {
    private let repository: GamesCatalogueRepositoryProtocol
    
    required init(repository: GamesCatalogueRepositoryProtocol) {
        self.repository = repository
    }
    
    func getAllFavorite() -> AnyPublisher<[GameDB], Error> {
        return repository.getAllFavorite()
    }
    
    func deleteFavorite(_ id: Int) -> AnyPublisher<Bool, Error> {
        return repository.deleteFavorite(id)
    }
}
