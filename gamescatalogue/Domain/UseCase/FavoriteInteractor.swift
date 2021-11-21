//
//  FavoriteInteractor.swift
//  gamescatalogue
//
//  Created by Alfa Centaury on 06/11/21.
//

import Foundation
import RxSwift

protocol FavoriteUseCase {
    func getAllFavorite() -> Observable<[GameDB]>
    
    func deleteFavorite(_ id: Int) -> Observable<Bool>
}

class FavoriteInteractor: FavoriteUseCase {
    private let repository: GamesCatalogueRepositoryProtocol
    
    required init(repository: GamesCatalogueRepositoryProtocol) {
        self.repository = repository
    }
    
    func getAllFavorite() -> Observable<[GameDB]> {
        return repository.getAllFavorite()
    }
    
    func deleteFavorite(_ id: Int) -> Observable<Bool> {
        return repository.deleteFavorite(id)
    }
}
