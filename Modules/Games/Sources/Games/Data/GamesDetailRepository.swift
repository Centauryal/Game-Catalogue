//
//  GamesDetailRepository.swift
//  
//
//  Created by Alfa Centaury on 11/12/21.
//

import Core
import Combine

public struct GamesDetailRepository<
    GetGameDetailRemoteData: RemoteDataSource,
    Transformer: Mapper>: Repository
where
GetGameDetailRemoteData.Response == DetailGameResponse,
GetGameDetailRemoteData.Request == String,
Transformer.Response == DetailGameResponse,
Transformer.Domain == Detail {
    
    public typealias Request = String
    public typealias Response = Detail
    
    private let _remoteDataSource: GetGameDetailRemoteData
    private let _mapper: Transformer
    
    public init(
        remoteDataSource: GetGameDetailRemoteData,
        mapper: Transformer) {
            _remoteDataSource = remoteDataSource
            _mapper = mapper
    }
    
    public func execute(request: String?) -> AnyPublisher<Detail, Error> {
        return _remoteDataSource.execute(request: request).map {
            return _mapper.transfomResponseToDomain(response: $0)
        }.eraseToAnyPublisher()
    }
}
