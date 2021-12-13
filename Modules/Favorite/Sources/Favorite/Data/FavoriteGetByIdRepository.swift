//
//  File.swift
//  
//
//  Created by Alfa Centaury on 11/12/21.
//

import Core
import Combine

public struct FavoriteGetByIdRepository<
    GetFavoriteLocaleData: LocaleDataSource,
    Transformer: LocaleMapper>: Repository
where
GetFavoriteLocaleData.Response == FavoriteModuleEntity,
GetFavoriteLocaleData.Request == Any,
Transformer.Entity == FavoriteModuleEntity,
Transformer.Domain == GameDB {
    
    public typealias Request = Int
    public typealias Response = GameDB
    
    private let _localeDataSource: GetFavoriteLocaleData
    private let _mapper: Transformer
    
    public init(
        localeDataSource: GetFavoriteLocaleData,
        mapper: Transformer) {
            _localeDataSource = localeDataSource
            _mapper = mapper
    }
    
    public func execute(request: Int?) -> AnyPublisher<GameDB, Error> {
        return _localeDataSource.getById(request ?? 0).map {
            return _mapper.transformEntityToDomain(entity: $0)
        }.eraseToAnyPublisher()
    }
}
