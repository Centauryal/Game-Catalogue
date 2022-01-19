//
//  SearchRouter.swift
//  gamescatalogue
//
//  Created by Alfa Centaury on 18/01/22.
//

import Foundation
import UIKit
import Core
import Games
import Favorite

class SearchRouter {
    func searchToDetail(for detailId: String) -> UIViewController {
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
        
        let presenter = DetailPresenter(idDetail: detailId,
                                        detailUseCase: detailUseCase,
                                        getFavoriteUseCase: getFavoriteUseCase,
                                        setFavoriteUseCase: setFavoriteUseCase,
                                        deleteFavoriteUseCase: deleteFavoriteUseCase)
        
        detail.detailPresenter = presenter
        return detail
    }
}
