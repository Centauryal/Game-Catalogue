//
//  FavoritePresenter.swift
//  gamescatalogue
//
//  Created by Alfa Centaury on 14/11/21.
//

import Foundation
import UIKit
import RxSwift

class FavoritePresenter: ObservableObject {
    private let favoriteUseCase: FavoriteUseCase
    var routerFavorite: FavoriteRouter?
    
    init(favoriteUseCase: FavoriteUseCase, router: FavoriteRouter) {
        self.favoriteUseCase = favoriteUseCase
        self.routerFavorite = router
    }
    
    func getAllFavorite() -> Observable<[GameDB]> {
        return favoriteUseCase.getAllFavorite()
    }
    
    func deleteFavorite(_ id: Int) -> Observable<Bool> {
        return favoriteUseCase.deleteFavorite(id)
    }
    
    func favoriteToDetail(view: UIViewController, detailId: Int) {
        guard let routerDetail = routerFavorite else { return }
        view.navigationController?.pushViewController(routerDetail.favoriteToDetail(for: detailId), animated: true)
    }
}
