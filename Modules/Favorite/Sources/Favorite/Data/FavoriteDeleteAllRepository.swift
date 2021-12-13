//
//  File.swift
//  
//
//  Created by Alfa Centaury on 12/12/21.
//

import Core
import Combine

public struct FavoriteDeleteAllRepository<
    GetFavoriteLocaleData: LocaleDataSource>: Repository
where
GetFavoriteLocaleData.Response == FavoriteModuleEntity,
GetFavoriteLocaleData.Request == Any {
    
    public typealias Request = Any
    public typealias Response = Bool
    
    private let _localeDataSource: GetFavoriteLocaleData
    
    public init(localeDataSource: GetFavoriteLocaleData) {
        _localeDataSource = localeDataSource
    }
    
    public func execute(request: Any?) -> AnyPublisher<Bool, Error> {
        return _localeDataSource.deleteAll(request: request)
    }
}
    
