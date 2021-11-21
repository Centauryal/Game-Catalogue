//
//  DetailPresenter.swift
//  gamescatalogue
//
//  Created by Alfa Centaury on 06/11/21.
//

import Foundation
import Combine

class DetailPresenter: ObservableObject {
    private let detailUseCase: DetailUseCase
    
    init(detailUseCase: DetailUseCase) {
        self.detailUseCase = detailUseCase
    }
    
    func getDetailGame() -> AnyPublisher<Detail, Error> {
        return detailUseCase.getDetailGame()
    }
    
    func getFavorite() -> AnyPublisher<GameDB, Error> {
        return detailUseCase.getFavorite()
    }
    
    func setFavorite(_ gameEntity: GameDB) -> AnyPublisher<Bool, Error> {
        return detailUseCase.setFavorite(gameEntity)
    }
    
    func deleteFavorite() -> AnyPublisher<Bool, Error> {
        return detailUseCase.deleteFavorite()
    }
}
