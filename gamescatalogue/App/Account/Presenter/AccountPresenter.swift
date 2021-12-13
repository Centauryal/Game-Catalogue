//
//  AccountPresenter.swift
//  gamescatalogue
//
//  Created by Alfa Centaury on 20/11/21.
//

import Foundation
import Combine
import Core
import Account

class AccountPresenter: ObservableObject {
    private let accountUseCase: GetPresenter<Any,
                                             Account,
                                             Interactor<Any,
                                                        Account,
                                                        AccountGetRepository<GetAccountLocaleData,
                                                                             AccountEntityMapper>>>
    
    private let accountSetUseCase: GetPresenter<Account,
                                                Bool,
                                                Interactor<Account,
                                                           Bool,
                                                           AccountSetRepository<GetAccountLocaleData,
                                                                                AccountEntityMapper>>>
    
    init(accountUseCase: Interactor<Any, Account, AccountGetRepository<GetAccountLocaleData, AccountEntityMapper>>,
         accountSetUseCase: Interactor<Account, Bool, AccountSetRepository<GetAccountLocaleData, AccountEntityMapper>>) {
        self.accountUseCase = GetPresenter(useCase: accountUseCase)
        self.accountSetUseCase = GetPresenter(useCase: accountSetUseCase)
    }
    
    func loadUserAccount(receiveCompletion: @escaping (Subscribers.Completion<Error>) -> Void,
                         receiveValue: @escaping (Account) -> Void) {
        return accountUseCase.getPresenter(
            request: nil,
            receiveCompletion: { completion in
                receiveCompletion(completion)
            }, receiveValue: { result in
                receiveValue(result)
            })
    }
    
    func addUserAccount(_ accountEntity: Account,
                        receiveCompletion: @escaping (Subscribers.Completion<Error>) -> Void,
                        receiveValue: @escaping (Bool) -> Void) {
        return accountSetUseCase.getPresenter(
            request: accountEntity,
            receiveCompletion: { completion in
                receiveCompletion(completion)
            },
            receiveValue: { result in
                receiveValue(result)
            })
    }
}
