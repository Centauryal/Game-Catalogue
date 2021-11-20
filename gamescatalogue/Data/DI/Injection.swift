//
//  Injection.swift
//  gamescatalogue
//
//  Created by Alfa Centaury on 05/11/21.
//

import Foundation

final class Injection: NSObject {
    private func provideRepository() -> GamesCatalogueRepositoryProtocol {
        let coreData = GameProvider.sharedManager.persistanContainer
        
        let remote: RemoteDataSource = RemoteDataSource.sharedInstance
        let locale: LocaleDataSource = LocaleDataSource.sharedInstance(coreData)
        
        return GamesCatalogueRepository.sharedInstance(remote, locale)
    }
    
    func provideHome() -> HomeUseCase {
        let repository = provideRepository()
        return HomeInteractor(repository: repository)
    }
    
    func provideDetail(idDetail id: String) -> DetailUseCase {
        let repository = provideRepository()
        return DetailInteractor(idDetail: id, repository: repository)
    }
    
    func provideFavorite() -> FavoriteUseCase {
        let repository = provideRepository()
        return FavoriteInteractor(repository: repository)
    }
    
    func provideAccount() -> AccountUseCase {
        let repository = provideRepository()
        return AccountInteractor(repository: repository)
    }
}
