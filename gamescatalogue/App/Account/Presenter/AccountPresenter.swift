//
//  AccountPresenter.swift
//  gamescatalogue
//
//  Created by Alfa Centaury on 20/11/21.
//

import Foundation
import RxSwift

class AccountPresenter: ObservableObject {
    private let accountUseCase: AccountUseCase
    
    init(accountUseCase: AccountUseCase) {
        self.accountUseCase = accountUseCase
    }
    
    func loadUserAccount() -> Observable<Account> {
        return accountUseCase.loadUserAccount()
    }
    
    func addUserAccount(_ accountEntity: Account) -> Observable<Bool> {
        return accountUseCase.addUserAccount(accountEntity)
    }
}
