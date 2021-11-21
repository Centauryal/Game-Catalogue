//
//  DetailInteractor.swift
//  gamescatalogue
//
//  Created by Alfa Centaury on 06/11/21.
//

import Foundation
import RxSwift

protocol DetailUseCase {
    func getDetailGame() -> Observable<Detail>
    
    func getFavorite() -> Observable<GameDB>
    
    func setFavorite(_ gameEntity: GameDB) -> Observable<Bool>
    
    func deleteFavorite() -> Observable<Bool>
}

class DetailInteractor: DetailUseCase {
    private let repository: GamesCatalogueRepositoryProtocol
    private let id: String
    
    required init(idDetail id: String, repository: GamesCatalogueRepositoryProtocol) {
        self.repository = repository
        self.id = id
    }
    
    func getDetailGame() -> Observable<Detail> {
        return repository.getDetailGame(idDetail: id)
    }
    
    func getFavorite() -> Observable<GameDB> {
        return repository.getFavorite(Int(id)!)
    }
    
    func setFavorite(_ gameEntity: GameDB) -> Observable<Bool> {
        return repository.setFavorite(gameEntity)
    }
    
    func deleteFavorite() -> Observable<Bool> {
        return repository.deleteFavorite(Int(id)!)
    }
}
