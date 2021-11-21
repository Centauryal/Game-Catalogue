//
//  HomeInteractor.swift
//  gamescatalogue
//
//  Created by Alfa Centaury on 06/11/21.
//

import Foundation
import Combine

protocol HomeUseCase {
    func getListGames() -> AnyPublisher<[Game], Error>
}

class HomeInteractor: HomeUseCase {
    private let repository: GamesCatalogueRepositoryProtocol
    
    required init(repository: GamesCatalogueRepositoryProtocol) {
        self.repository = repository
    }
    
    func getListGames() -> AnyPublisher<[Game], Error> {
        return repository.getListGames()
    }
}
