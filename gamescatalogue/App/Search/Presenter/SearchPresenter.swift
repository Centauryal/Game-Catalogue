//
//  SearchPresenter.swift
//  gamescatalogue
//
//  Created by Alfa Centaury on 18/01/22.
//

import UIKit

class SearchPresenter: ObservableObject {
    var router: SearchRouter?
    
    init(router: SearchRouter) {
        self.router = router
    }
    
    func searchToDetail(view: ViewController, detailId: String) {
        guard let routerDetail = router else { return }
        view.navigationController?.pushViewController(routerDetail.searchToDetail(for: detailId), animated: true)
    }
}
