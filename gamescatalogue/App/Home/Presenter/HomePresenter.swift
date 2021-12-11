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
    var homeView: UIViewController?
    var router: HomeRouter?
    
    init(homeUseCase: Interactor<Any, [Game], GamesRepository<GetGamesRemoteData, GameResultMapper>>,
         router: HomeRouter) {
        self.homeUseCase = GetPresenter(useCase: homeUseCase)
        self.router = router
    }
    
    func getListGames(receiveCompletion: @escaping (Subscribers.Completion<Error>) -> Void,
                      receiveValue: @escaping ([Game]) -> Void) {
        return homeUseCase.getPresenter(request: nil,
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
