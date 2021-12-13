//
//  File.swift
//  
//
//  Created by Alfa Centaury on 11/12/21.
//

import Core
import Combine

public struct FavoriteRepository<
    GetFavoriteLocaleData: LocaleDataSource,
    Transformer: LocaleMapper>: Repository
where
GetFavoriteLocaleData.Response == FavoriteModuleEntity,
GetFavoriteLocaleData.Request == Any,
Transformer.Entity == [FavoriteModuleEntity],
Transformer.Domain == [GameDB] {
    
    public typealias Request = Any
    public typealias Response = [GameDB]
    
    private let _localeDataSource: GetFavoriteLocaleData
    private let _mapper: Transformer
    
    public init(
        localeDataSource: GetFavoriteLocaleData,
        mapper: Transformer) {
            _localeDataSource = localeDataSource
            _mapper = mapper
    }
    
    public func execute(request: Any?) -> AnyPublisher<[GameDB], Error> {
        return _localeDataSource.getAllList(request: request).map {
            return _mapper.transformEntityToDomain(entity: $0)
        }.eraseToAnyPublisher()
    }
}
