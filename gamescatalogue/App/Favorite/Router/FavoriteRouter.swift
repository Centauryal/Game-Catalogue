//
//  FavoriteRouter.swift
//  gamescatalogue
//
//  Created by Alfa Centaury on 14/11/21.
//

import Foundation
import UIKit
import Core
import Games
import Favorite

class FavoriteRouter {
    func favoriteToDetail(for detailId: Int) -> UIViewController {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let detail = storyboard.instantiateViewController(identifier: "DetailGameViewController") as DetailGameViewController
        let detailUseCase: Interactor<String,
                                      Detail,
                                      GamesDetailRepository<
                                        GetGameDetailRemoteData,
                                        DetailResultMapper>
        > = Injection.init().provideDetail()
        let getFavoriteUseCase: Interactor<Int,
                                           GameDB,
                                           FavoriteGetByIdRepository<
                                            GetFavoriteLocaleData,
                                            DetailEntityMapper>
        > = Injection.init().provideGetFavorite()
        let setFavoriteUseCase: Interactor<GameDB,
                                           Bool,
                                           FavoriteSetRepository<
                                            GetFavoriteLocaleData,
                                            DetailEntityMapper>
        > = Injection.init().provideSetFavorite()
        let deleteFavoriteUseCase: Interactor<Int,
                                              Bool,
                                              FavoriteDeleteByIdRepository<
                                                GetFavoriteLocaleData>
        > = Injection.init().provideDeleteFavorite()
        
        let presenter = DetailPresenter(idDetail: String(detailId),
                                        detailUseCase: detailUseCase,
                                        getFavoriteUseCase: getFavoriteUseCase,
                                        setFavoriteUseCase: setFavoriteUseCase,
                                        deleteFavoriteUseCase: deleteFavoriteUseCase)
        
        detail.detailPresenter = presenter
        detail.fromFavorite = 1
        return detail
    }
}
