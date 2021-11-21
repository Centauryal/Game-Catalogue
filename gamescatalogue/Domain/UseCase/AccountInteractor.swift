//
//  AccountInteractor.swift
//  gamescatalogue
//
//  Created by Alfa Centaury on 06/11/21.
//

import Foundation
import Combine

protocol AccountUseCase {
    func loadUserAccount() -> AnyPublisher<Account, Error>
    
    func addUserAccount(_ accountEntity: Account) -> AnyPublisher<Bool, Error>
}

class AccountInteractor: AccountUseCase {
    private let repository: GamesCatalogueRepositoryProtocol
    
    required init(repository: GamesCatalogueRepositoryProtocol) {
        self.repository = repository
    }
    
    func loadUserAccount() -> AnyPublisher<Account, Error> {
        return repository.loadUserAccount()
    }
    
    func addUserAccount(_ accountEntity: Account) -> AnyPublisher<Bool, Error> {
        return repository.addUserAccount(accountEntity)
    }
}
