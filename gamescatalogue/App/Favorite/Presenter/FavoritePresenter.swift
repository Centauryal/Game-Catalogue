//
//  FavoritePresenter.swift
//  gamescatalogue
//
//  Created by Alfa Centaury on 14/11/21.
//

import Foundation
import UIKit
import Combine
import Core
import Favorite

class FavoritePresenter: ObservableObject {
    private let favoriteUseCase: GetPresenter<Any,
                                              [GameDB],
                                              Interactor<Any,
                                                         [GameDB],
                                                         FavoriteRepository<GetFavoriteLocaleData,
                                                                            FavoriteEntityMapper>>>
    
    private let deleteFavoriteUseCase: GetPresenter<Int,
                                                    Bool,
                                                    Interactor<Int,
                                                               Bool,
                                                               FavoriteDeleteByIdRepository<GetFavoriteLocaleData>>>
    
    var routerFavorite: FavoriteRouter?
    
    init(favoriteUseCase: Interactor<Any, [GameDB], FavoriteRepository<GetFavoriteLocaleData, FavoriteEntityMapper>>,
         deleteFavoriteUseCase: Interactor<Int, Bool, FavoriteDeleteByIdRepository<GetFavoriteLocaleData>>,
         router: FavoriteRouter) {
        self.favoriteUseCase = GetPresenter(useCase: favoriteUseCase)
        self.deleteFavoriteUseCase = GetPresenter(useCase: deleteFavoriteUseCase)
        self.routerFavorite = router
    }
    
    func getAllFavorite(receiveCompletion: @escaping (Subscribers.Completion<Error>) -> Void,
                        receiveValue: @escaping ([GameDB]) -> Void) {
        return favoriteUseCase.getPresenter(request: nil,
           receiveCompletion: { completion in
            receiveCompletion(completion)
        }, receiveValue: { result in
            receiveValue(result)
        })
    }
    
    func deleteFavorite(_ id: Int,
                        receiveCompletion: @escaping (Subscribers.Completion<Error>) -> Void,
                        receiveValue: @escaping (Bool) -> Void) {
                            return deleteFavoriteUseCase.getPresenter(request: id,
                                                                      receiveCompletion: { completion in
                                receiveCompletion(completion)
                            }, receiveValue: { result in
                                receiveValue(result)
                            })
    }
    
    func favoriteToDetail(view: UIViewController, detailId: Int) {
        guard let routerDetail = routerFavorite else { return }
        view.navigationController?.pushViewController(routerDetail.favoriteToDetail(for: detailId), animated: true)
    }
}
