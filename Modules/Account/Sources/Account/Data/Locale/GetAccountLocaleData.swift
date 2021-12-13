//
//  File.swift
//  
//
//  Created by Alfa Centaury on 13/12/21.
//

import Foundation
import Core
import Combine

public struct GetAccountLocaleData: LocaleDataSource {
    
    public typealias Request = Any
    public typealias Response = AccountModuleEntity
    
    private let _userDefault: UserDefaults
    
    public init() {
        self._userDefault = UserDefaultProvider.sharedManager.userDefaultsAccount()
    }
    
    public func getAllList(request: Any?) -> AnyPublisher<[AccountModuleEntity], Error> {
        fatalError()
    }
    
    public func getById(_ id: Int) -> AnyPublisher<AccountModuleEntity, Error> {
        fatalError()
    }
    
    public func set(_ entity: AccountModuleEntity) -> AnyPublisher<Bool, Error> {
        return Future<Bool, Error> { completion in
            let user = self._userDefault
            
            do {
                try user.setObject(entity, forKey: "Account")
                completion(.success(true))
            } catch {
                completion(.failure(LocaleError.requestFailed))
            }
        }.eraseToAnyPublisher()
    }
    
    public func deleteAll(request: Any?) -> AnyPublisher<Bool, Error> {
        fatalError()
    }
    
    public func deleteById(_ id: Int) -> AnyPublisher<Bool, Error> {
        fatalError()
    }
    
    public func loadUserDefault() -> AnyPublisher<AccountModuleEntity, Error> {
        return Future<AccountModuleEntity, Error> { completion in
            let user = self._userDefault
            
            do {
                let account = try user.getObject(forKey: "Account", castTo: AccountModuleEntity.self)
                completion(.success(account))
            } catch {
                completion(.failure(LocaleError.requestFailed))
            }
        }.eraseToAnyPublisher()
    }
}
