//
//  AccountPresenter.swift
//  gamescatalogue
//
//  Created by Alfa Centaury on 20/11/21.
//

import Foundation

class AccountPresenter: ObservableObject {
    private let accountUseCase: AccountUseCase
    
    init(accountUseCase: AccountUseCase) {
        self.accountUseCase = accountUseCase
    }
    
    func loadUserAccount(completion: @escaping(Result<Account, LocaleError>) -> Void) {
        return accountUseCase.loadUserAccount { result in
            completion(result)
        }
    }
    
    func addUserAccount(_ accountEntity: Account, completion: @escaping(Result<Bool, LocaleError>) -> Void) {
        return accountUseCase.addUserAccount(accountEntity) { result in
            completion(result)
        }
    }
}
