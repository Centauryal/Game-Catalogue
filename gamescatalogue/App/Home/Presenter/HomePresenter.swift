//
//  HomePresenter.swift
//  gamescatalogue
//
//  Created by Alfa Centaury on 06/11/21.
//

import UIKit
import Combine
import Core
import Games

class HomePresenter: ObservableObject {
    private let homeUseCase: GetPresenter<Any,
                                        [Game],
                                        Interactor<Any,
                                                   [Game],
                                                   GamesRepository<GetGamesRemoteData,
                                                                   GameResultMapper>>>
    
    private let searchUseCase: GetPresenter<String,
                                            [Game],
                                            Interactor<String,
                                                       [Game],
                                                       GamesSearchRepository<GetGameSearchRemoteData,
                                                                             GameResultMapper>>>
    
    var homeView: UIViewController?
    var router: HomeRouter?
    
    init(homeUseCase: Interactor<Any, [Game],
         GamesRepository<GetGamesRemoteData, GameResultMapper>>,
         searchUseCase: Interactor<String, [Game],
         GamesSearchRepository<GetGameSearchRemoteData, GameResultMapper>>,
         router: HomeRouter) {
        self.homeUseCase = GetPresenter(useCase: homeUseCase)
        self.searchUseCase = GetPresenter(useCase: searchUseCase)
        self.router = router
    }
    
    func getListGames(page: String,
                      receiveCompletion: @escaping (Subscribers.Completion<Error>) -> Void,
                      receiveValue: @escaping ([Game]) -> Void) {
        return homeUseCase.getPresenter(request: page,
           receiveCompletion: { completion in
            receiveCompletion(completion)
        }, receiveValue: { result in
            receiveValue(result)
        })
    }
    
    func getSearchGames(text: String,
                        receiveCompletion: @escaping (Subscribers.Completion<Error>) -> Void,
                        receiveValue: @escaping ([Game]) -> Void) {
        return searchUseCase.getPresenter(request: text,
           receiveCompletion: { completion in
            receiveCompletion(completion)
        }, receiveValue: { result in
            receiveValue(result)
        })
    }
    
    func toDetail(view: UIViewController, detailId: String) {
        guard let routerDetail = router else { return }
        view.navigationController?.pushViewController(routerDetail.toDetailView(for: detailId), animated: true)
    }
}
