//
//  FavoritePresenter.swift
//  gamescatalogue
//
//  Created by Alfa Centaury on 14/11/21.
//

import Foundation
import UIKit

class FavoritePresenter: ObservableObject {
    private let favoriteUseCase: FavoriteUseCase
    var routerFavorite: FavoriteRouter?
    
    init(favoriteUseCase: FavoriteUseCase, router: FavoriteRouter) {
        self.favoriteUseCase = favoriteUseCase
        self.routerFavorite = router
    }
    
    func getAllFavorite(completion: @escaping(Result<[GameDB], Error>) -> Void) {
        return favoriteUseCase.getAllFavorite { result in
            completion(result)
        }
    }
    
    func deleteFavorite(_ id: Int, completion: @escaping(Result<Bool, Error>) -> Void) {
        return favoriteUseCase.deleteFavorite(id) { result in
            completion(result)
        }
    }
    
    func favoriteToDetail(view: UIViewController, detailId: Int) {
        guard let routerDetail = routerFavorite else { return }
        view.navigationController?.pushViewController(routerDetail.favoriteToDetail(for: detailId), animated: true)
    }
}
