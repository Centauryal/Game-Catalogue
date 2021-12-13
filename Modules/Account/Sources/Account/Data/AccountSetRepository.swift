//
//  File.swift
//  
//
//  Created by Alfa Centaury on 13/12/21.
//

import Core
import Combine

public struct AccountSetRepository<
    GetAccountLocaleData: LocaleDataSource,
    Transformer: LocaleMapper>: Repository
where
GetAccountLocaleData.Response == AccountModuleEntity,
GetAccountLocaleData.Request == Any,
Transformer.Entity == AccountModuleEntity,
Transformer.Domain == Account {
    
    public typealias Request = Account
    public typealias Response = Bool
    
    private let _localeDataSource: GetAccountLocaleData
    private let _mapper: Transformer
    
    public init(
        localDataSource: GetAccountLocaleData,
        mapper: Transformer) {
            _localeDataSource = localDataSource
            _mapper = mapper
    }
    
    public func execute(request: Account?) -> AnyPublisher<Bool, Error> {
        return _localeDataSource.set(_mapper.transfomDomainToEntity(domain: request!))
    }
}
