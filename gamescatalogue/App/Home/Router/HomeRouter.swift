//
//  HomeRouter.swift
//  gamescatalogue
//
//  Created by Alfa Centaury on 06/11/21.
//

import Foundation
import UIKit
import Core
import Games

class HomeRouter {
    func createHome() -> UINavigationController {
        UIView.appearance().tintColor = UIColor(named: "PrimaryColor")
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let home = storyboard.instantiateViewController(identifier: "ViewController") as ViewController
        let homeUseCase: Interactor<Any,
                                    [Game],
                                    GamesRepository<
                                        GetGamesRemoteData,
                                        GameResultMapper>
        > = Injection.init().provideHome()
        let presenter = HomePresenter(homeUseCase: homeUseCase, router: HomeRouter())
        
        home.presenter = presenter
        home.presenter?.homeView = home
        let navigationController = UINavigationController(rootViewController: home)
        navigationController.navigationBar.prefersLargeTitles = true
        
        return navigationController
    }
    
    func toDetailView(for detailId: String) -> UIViewController {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let detail = storyboard.instantiateViewController(identifier: "DetailGameViewController") as DetailGameViewController
        let detailUseCase: Interactor<String,
                                      Detail,
                                      GamesDetailRepository<
                                        GetGameDetailRemoteData,
                                        DetailResultMapper>
        > = Injection.init().provideDetail()
        let presenter = DetailPresenter(idDetail: detailId, detailUseCase: detailUseCase)
        
        detail.detailPresenter = presenter
        return detail
    }
//    
//    func toFavoriteView() -> FavoritePresenter {
//        let favoriteUseCase = Injection.init().provideFavorite()
//        let presenter = FavoritePresenter(favoriteUseCase: favoriteUseCase, router: FavoriteRouter())
//        
//        return presenter
//    }
//    
//    func toAccountView() -> AccountPresenter {
//        let accountUseCase = Injection.init().provideAccount()
//        let presenter = AccountPresenter(accountUseCase: accountUseCase)
//        
//        return presenter
//    }
}
