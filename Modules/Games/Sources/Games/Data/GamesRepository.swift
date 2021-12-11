//
//  File.swift
//  
//
//  Created by Alfa Centaury on 07/12/21.
//

import Core
import Combine

public struct GamesRepository<
    GetGamesRemoteData: RemoteDataSource,
    Transformer: Mapper>: Repository
where
GetGamesRemoteData.Response == [ResultsGames],
GetGamesRemoteData.Request == Any,
Transformer.Response == [ResultsGames],
Transformer.Domain == [Game] {
    
    public typealias Request = Any
    public typealias Response = [Game]
        
    private let _remoteDataSource: GetGamesRemoteData
    private let _mapper: Transformer
    
    public init(
        remoteDataSource: GetGamesRemoteData,
        mapper: Transformer) {
            _remoteDataSource = remoteDataSource
            _mapper = mapper
    }
    
    public func execute(request: Any?) -> AnyPublisher<[Game], Error> {
        return _remoteDataSource.execute(request: request).map {
            return _mapper.transfomResponseToDomain(response: $0)
        }.eraseToAnyPublisher()
    }
}
