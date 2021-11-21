//
//  HomeInteractor.swift
//  gamescatalogue
//
//  Created by Alfa Centaury on 06/11/21.
//

import Foundation
import RxSwift

protocol HomeUseCase {
    func getListGames() -> Observable<[Game]>
}

class HomeInteractor: HomeUseCase {
    private let repository: GamesCatalogueRepositoryProtocol
    
    required init(repository: GamesCatalogueRepositoryProtocol) {
        self.repository = repository
    }
    
    func getListGames() -> Observable<[Game]> {
        return repository.getListGames()
    }
}
