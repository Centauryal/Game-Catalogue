//
//  AccountInteractor.swift
//  gamescatalogue
//
//  Created by Alfa Centaury on 06/11/21.
//

import Foundation

protocol AccountUseCase {
    func loadUserAccount(completion: @escaping(Result<Account, LocaleError>) -> Void)
    
    func addUserAccount(_ accountEntity: Account, completion: @escaping(Result<Bool, LocaleError>) -> Void)
}

class AccountInteractor: AccountUseCase {
    private let repository: GamesCatalogueRepositoryProtocol
    
    required init(repository: GamesCatalogueRepositoryProtocol) {
        self.repository = repository
    }
    
    func loadUserAccount(completion: @escaping(Result<Account, LocaleError>) -> Void) {
        repository.loadUserAccount { result in
            completion(result)
        }
    }
    
    func addUserAccount(_ accountEntity: Account, completion: @escaping(Result<Bool, LocaleError>) -> Void) {
        repository.addUserAccount(accountEntity) { result in
            completion(result)
        }
    }
}
