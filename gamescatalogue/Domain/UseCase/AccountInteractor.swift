//
//  AccountInteractor.swift
//  gamescatalogue
//
//  Created by Alfa Centaury on 06/11/21.
//

import Foundation
import RxSwift

protocol AccountUseCase {
    func loadUserAccount() -> Observable<Account>
    
    func addUserAccount(_ accountEntity: Account) -> Observable<Bool>
}

class AccountInteractor: AccountUseCase {
    private let repository: GamesCatalogueRepositoryProtocol
    
    required init(repository: GamesCatalogueRepositoryProtocol) {
        self.repository = repository
    }
    
    func loadUserAccount() -> Observable<Account> {
        return repository.loadUserAccount()
    }
    
    func addUserAccount(_ accountEntity: Account) -> Observable<Bool> {
        return repository.addUserAccount(accountEntity)
    }
}
