//
//  FavoriteRouter.swift
//  gamescatalogue
//
//  Created by Alfa Centaury on 14/11/21.
//

import Foundation
import UIKit

class FavoriteRouter {
    func favoriteToDetail(for detailId: Int) -> UIViewController {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let detail = storyboard.instantiateViewController(identifier: "DetailGameViewController") as DetailGameViewController
        let detailUseCase = Injection.init().provideDetail(idDetail: String(detailId))
        let presenter = DetailPresenter(detailUseCase: detailUseCase)
        
        detail.detailPresenter = presenter
        detail.fromFavorite = 1
        return detail
    }
}
