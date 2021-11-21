//
//  DetailInteractor.swift
//  gamescatalogue
//
//  Created by Alfa Centaury on 06/11/21.
//

import Foundation
import Combine

protocol DetailUseCase {
    func getDetailGame() -> AnyPublisher<Detail, Error>
    
    func getFavorite() -> AnyPublisher<GameDB, Error>
    
    func setFavorite(_ gameEntity: GameDB) -> AnyPublisher<Bool, Error>
    
    func deleteFavorite() -> AnyPublisher<Bool, Error>
}

class DetailInteractor: DetailUseCase {
    private let repository: GamesCatalogueRepositoryProtocol
    private let id: String
    
    required init(idDetail id: String, repository: GamesCatalogueRepositoryProtocol) {
        self.repository = repository
        self.id = id
    }
    
    func getDetailGame() -> AnyPublisher<Detail, Error> {
        return repository.getDetailGame(idDetail: id)
    }
    
    func getFavorite() -> AnyPublisher<GameDB, Error> {
        return repository.getFavorite(Int(id)!)
    }
    
    func setFavorite(_ gameEntity: GameDB) -> AnyPublisher<Bool, Error> {
        return repository.setFavorite(gameEntity)
    }
    
    func deleteFavorite() -> AnyPublisher<Bool, Error> {
        return repository.deleteFavorite(Int(id)!)
    }
}
