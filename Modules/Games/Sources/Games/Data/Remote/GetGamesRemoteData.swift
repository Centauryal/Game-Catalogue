//
//  File.swift
//  
//
//  Created by Alfa Centaury on 07/12/21.
//

import Foundation
import Core
import Combine
import Alamofire
import Common

public struct GetGamesRemoteData: RemoteDataSource {
    public typealias Request = Any
    public typealias Response = [ResultsGames]
    
    private let _endpoint: String
    
    public init(endpoint: String) {
        _endpoint = endpoint
    }
    
    public func execute(request: Any?) -> AnyPublisher<[ResultsGames], Error> {
        return Future<[ResultsGames], Error> { completion in
            var urlListGames = URLComponents(string: _endpoint)
            urlListGames?.queryItems = [
                URLQueryItem(name: "key", value: ApiService.apiKey)
            ]
            
            if let urlRequest = urlListGames?.url {
                let request = URLRequest(url: urlRequest)
                
                AF.request(request).validate().responseDecodable(of: GamesResponse.self) { response in
                    switch response.result {
                    case .success(let value):
                        completion(.success(value.results))
                    case .failure:
                        completion(.failure(URLError.invalidResponse))
                    }
                }
            }
        }.eraseToAnyPublisher()
    }
}
