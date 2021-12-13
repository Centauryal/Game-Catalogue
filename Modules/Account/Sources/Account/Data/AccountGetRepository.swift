//
//  File.swift
//  
//
//  Created by Alfa Centaury on 13/12/21.
//

import Core
import Combine

public struct AccountGetRepository<
    GetAccountLocaleData: LocaleDataSource,
    Transformer: LocaleMapper>: Repository
where
GetAccountLocaleData.Response == AccountModuleEntity,
GetAccountLocaleData.Request == Any,
Transformer.Entity == AccountModuleEntity,
Transformer.Domain == Account {
    
    public typealias Request = Any
    public typealias Response = Account
    
    private let _localeDataSource: GetAccountLocaleData
    private let _mapper: Transformer
    
    public init(
        localDataSource: GetAccountLocaleData,
        mapper: Transformer) {
            _localeDataSource = localDataSource
            _mapper = mapper
    }
    
    public func execute(request: Any?) -> AnyPublisher<Account, Error> {
        return _localeDataSource.loadUserDefault().map {
            return _mapper.transformEntityToDomain(entity: $0)
        }.eraseToAnyPublisher()
    }
}
