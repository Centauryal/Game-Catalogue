//
//  File.swift
//  
//
//  Created by Alfa Centaury on 18/01/22.
//

import Core
import Combine

public struct GamesSearchRepository<
    GetGameSearchRemoteData: RemoteDataSource,
    Transformer: Mapper>: Repository
where
GetGameSearchRemoteData.Response == [ResultsGames],
GetGameSearchRemoteData.Request == String,
Transformer.Response == [ResultsGames],
Transformer.Domain == [Game] {
    
    public typealias Request = String
    public typealias Response = [Game]
    
    private let _remoteDataSource: GetGameSearchRemoteData
    private let _mapper: Transformer
    
    public init(
        remoteDataSource: GetGameSearchRemoteData,
        mapper: Transformer) {
            _remoteDataSource = remoteDataSource
            _mapper = mapper
    }
    
    public func execute(request: String?) -> AnyPublisher<[Game], Error> {
        return _remoteDataSource.execute(request: request).map {
            return _mapper.transfomResponseToDomain(response: $0)
        }.eraseToAnyPublisher()
    }
}
