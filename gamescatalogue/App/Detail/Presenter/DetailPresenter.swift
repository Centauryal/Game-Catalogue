//
//  DetailPresenter.swift
//  gamescatalogue
//
//  Created by Alfa Centaury on 06/11/21.
//

import Foundation
import Combine
import Core
import Games

class DetailPresenter: ObservableObject {
    private var idDetail: String = ""
    private let detailUseCase: GetPresenter<String,
                                            Detail,
                                            Interactor<String,
                                                       Detail,
                                                       GamesDetailRepository<GetGameDetailRemoteData,
                                                                             DetailResultMapper>>>

    init(idDetail: String,
         detailUseCase: Interactor<String, Detail, GamesDetailRepository<GetGameDetailRemoteData, DetailResultMapper>>) {
        self.idDetail = idDetail
        self.detailUseCase = GetPresenter(useCase: detailUseCase)
    }
    
    func getDetailGame(receiveCompletion: @escaping (Subscribers.Completion<Error>) -> Void,
                       receiveValue: @escaping (Detail) -> Void) {
        return detailUseCase.getPresenter(request: idDetail,
           receiveCompletion: { completion in
            receiveCompletion(completion)
        }, receiveValue: { result in
            receiveValue(result)
        })
    }
    
//    func getFavorite() -> AnyPublisher<GameDB, Error> {
//        return detailUseCase.getFavorite()
//    }
//
//    func setFavorite(_ gameEntity: GameDB) -> AnyPublisher<Bool, Error> {
//        return detailUseCase.setFavorite(gameEntity)
//    }
//
//    func deleteFavorite() -> AnyPublisher<Bool, Error> {
//        return detailUseCase.deleteFavorite()
//    }
}
