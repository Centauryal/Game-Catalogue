//
//  File.swift
//  
//
//  Created by Alfa Centaury on 11/12/21.
//

import Core
import Combine

public struct FavoriteSetRepository<
    GetFavoriteLocaleData: LocaleDataSource,
    Transformer: LocaleMapper>: Repository
where
GetFavoriteLocaleData.Response == FavoriteModuleEntity,
GetFavoriteLocaleData.Request == Any,
Transformer.Entity == FavoriteModuleEntity,
Transformer.Domain == GameDB {
    
    public typealias Request = GameDB
    public typealias Response = Bool
    
    private let _localeDataSource: GetFavoriteLocaleData
    private let _mapper: Transformer
    
    public init(
        localeDataSource: GetFavoriteLocaleData,
        mapper: Transformer) {
            _localeDataSource = localeDataSource
            _mapper = mapper
    }
    
    public func execute(request: GameDB?) -> AnyPublisher<Bool, Error> {
        return _localeDataSource.set(_mapper.transfomDomainToEntity(domain: request!))
    }
}
