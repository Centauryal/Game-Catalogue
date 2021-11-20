//
//  HomePresenter.swift
//  gamescatalogue
//
//  Created by Alfa Centaury on 06/11/21.
//

import Foundation
import UIKit

class HomePresenter: ObservableObject {
    private let homeUseCase: HomeUseCase
    var homeView: UIViewController?
    var router: HomeRouter?
    
    init(homeUseCase: HomeUseCase, router: HomeRouter) {
        self.homeUseCase = homeUseCase
        self.router = router
    }
    
    func getListGames(completion: @escaping (Result<[Game], Error>) -> Void) {
        return homeUseCase.getListGames { result in
            completion(result)
        }
    }
    
    func toDetail(view: UIViewController, detailId: String) {
        guard let routerDetail = router else { return }
        view.navigationController?.pushViewController(routerDetail.toDetailView(for: detailId), animated: true)
    }
}
