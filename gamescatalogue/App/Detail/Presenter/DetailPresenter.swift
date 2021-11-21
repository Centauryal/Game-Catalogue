//
//  DetailPresenter.swift
//  gamescatalogue
//
//  Created by Alfa Centaury on 06/11/21.
//

import Foundation
import RxSwift

class DetailPresenter: ObservableObject {
    private let detailUseCase: DetailUseCase
    
    init(detailUseCase: DetailUseCase) {
        self.detailUseCase = detailUseCase
    }
    
    func getDetailGame() -> Observable<Detail> {
        return detailUseCase.getDetailGame()
    }
    
    func getFavorite() -> Observable<GameDB> {
        return detailUseCase.getFavorite()
    }
    
    func setFavorite(_ gameEntity: GameDB) -> Observable<Bool> {
        return detailUseCase.setFavorite(gameEntity)
    }
    
    func deleteFavorite() -> Observable<Bool> {
        return detailUseCase.deleteFavorite()
    }
}
