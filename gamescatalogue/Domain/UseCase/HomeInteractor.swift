//
//  HomeInteractor.swift
//  gamescatalogue
//
//  Created by Alfa Centaury on 06/11/21.
//

import Foundation

protocol HomeUseCase {
    func getListGames(completion: @escaping (Result<[Game], Error>) -> Void)
}

class HomeInteractor: HomeUseCase {
    private let repository: GamesCatalogueRepositoryProtocol
    
    required init(repository: GamesCatalogueRepositoryProtocol) {
        self.repository = repository
    }
    
    func getListGames(completion: @escaping (Result<[Game], Error>) -> Void) {
        repository.getListGames { result in
            completion(result)
        }
    }
}
