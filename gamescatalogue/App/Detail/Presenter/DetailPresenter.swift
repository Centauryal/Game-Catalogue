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
import Favorite

class DetailPresenter: ObservableObject {
    private var idDetail: String = ""
    private let detailUseCase: GetPresenter<String,
                                            Detail,
                                            Interactor<String,
                                                       Detail,
                                                       GamesDetailRepository<GetGameDetailRemoteData,
                                                                             DetailResultMapper>>>

    private let getFavoriteUseCase: GetPresenter<Int,
                                                 GameDB,
                                                 Interactor<Int,
                                                            GameDB,
                                                            FavoriteGetByIdRepository<GetFavoriteLocaleData,
                                                                                      DetailEntityMapper>>>
    
    private let setFavoriteUseCase: GetPresenter<GameDB,
                                                 Bool,
                                                 Interactor<GameDB,
                                                            Bool,
                                                            FavoriteSetRepository<GetFavoriteLocaleData,
                                                                                  DetailEntityMapper>>>
    
    private let deleteFavoriteUseCase: GetPresenter<Int,
                                                    Bool,
                                                    Interactor<Int,
                                                               Bool,
                                                               FavoriteDeleteByIdRepository<GetFavoriteLocaleData>>>
    
    init(idDetail: String,
         detailUseCase: Interactor<String, Detail, GamesDetailRepository<GetGameDetailRemoteData, DetailResultMapper>>,
         getFavoriteUseCase: Interactor<Int, GameDB, FavoriteGetByIdRepository<GetFavoriteLocaleData, DetailEntityMapper>>,
         setFavoriteUseCase: Interactor<GameDB, Bool, FavoriteSetRepository<GetFavoriteLocaleData, DetailEntityMapper>>,
         deleteFavoriteUseCase: Interactor<Int, Bool, FavoriteDeleteByIdRepository<GetFavoriteLocaleData>>) {
        self.idDetail = idDetail
        self.detailUseCase = GetPresenter(useCase: detailUseCase)
        self.getFavoriteUseCase = GetPresenter(useCase: getFavoriteUseCase)
        self.setFavoriteUseCase = GetPresenter(useCase: setFavoriteUseCase)
        self.deleteFavoriteUseCase = GetPresenter(useCase: deleteFavoriteUseCase)
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
    
    func getFavorite(receiveCompletion: @escaping (Subscribers.Completion<Error>) -> Void,
                     receiveValue: @escaping (GameDB) -> Void) {
        return getFavoriteUseCase.getPresenter(request: Int(idDetail),
           receiveCompletion: { completion in
            receiveCompletion(completion)
        }, receiveValue: { result in
            receiveValue(result)
        })
    }

    func setFavorite(_ gameEntity: GameDB,
                     receiveCompletion: @escaping (Subscribers.Completion<Error>) -> Void,
                     receiveValue: @escaping (Bool) -> Void) {
        return setFavoriteUseCase.getPresenter(request: gameEntity,
           receiveCompletion: { completion in
            receiveCompletion(completion)
        }, receiveValue: { result in
            receiveValue(result)
        })
    }

    func deleteFavorite(receiveCompletion: @escaping (Subscribers.Completion<Error>) -> Void,
                        receiveValue: @escaping (Bool) -> Void) {
        return deleteFavoriteUseCase.getPresenter(request: Int(idDetail),
           receiveCompletion: { completion in
            receiveCompletion(completion)
        }, receiveValue: { result in
            receiveValue(result)
        })
    }
}
