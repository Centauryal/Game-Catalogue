//
//  DetailPresenter.swift
//  gamescatalogue
//
//  Created by Alfa Centaury on 06/11/21.
//

import Foundation

class DetailPresenter: ObservableObject {
    private let detailUseCase: DetailUseCase
    
    init(detailUseCase: DetailUseCase) {
        self.detailUseCase = detailUseCase
    }
    
    func getDetailGame(completion: @escaping (Result<Detail, Error>) -> Void) {
        return detailUseCase.getDetailGame { result in
            completion(result)
        }
    }
    
    func getFavorite(completion: @escaping(Result<GameDB, Error>) -> Void) {
        return detailUseCase.getFavorite { result in
            completion(result)
        }
    }
    
    func setFavorite(_ gameEntity: GameDB, completion: @escaping(Result<Bool, Error>) -> Void) {
        return detailUseCase.setFavorite(gameEntity) { result in
            completion(result)
        }
    }
    
    func deleteFavorite(completion: @escaping(Result<Bool, Error>) -> Void) {
        return detailUseCase.deleteFavorite { result in
            completion(result)
        }
    }
}
