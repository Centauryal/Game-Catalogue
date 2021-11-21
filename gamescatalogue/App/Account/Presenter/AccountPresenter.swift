//
//  AccountPresenter.swift
//  gamescatalogue
//
//  Created by Alfa Centaury on 20/11/21.
//

import Foundation
import Combine

class AccountPresenter: ObservableObject {
    private let accountUseCase: AccountUseCase
    
    init(accountUseCase: AccountUseCase) {
        self.accountUseCase = accountUseCase
    }
    
    func loadUserAccount() -> AnyPublisher<Account, Error> {
        return accountUseCase.loadUserAccount()
    }
    
    func addUserAccount(_ accountEntity: Account) -> AnyPublisher<Bool, Error> {
        return accountUseCase.addUserAccount(accountEntity)
    }
}
