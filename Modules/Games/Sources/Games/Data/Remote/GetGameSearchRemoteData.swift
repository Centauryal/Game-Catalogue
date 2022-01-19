//
//  File.swift
//  
//
//  Created by Alfa Centaury on 18/01/22.
//

import Foundation
import Core
import Combine
import Alamofire
import Common

public struct GetGameSearchRemoteData: RemoteDataSource {
    public typealias Request = String
    public typealias Response = [ResultsGames]
    
    private let _endpoint: String
    
    public init(endpoint: String) {
        _endpoint = endpoint
    }
    
    public func execute(request: String?) -> AnyPublisher<[ResultsGames], Error> {
        return Future<[ResultsGames], Error> { completion in
            var urlSearchGames = URLComponents(string: _endpoint)
            urlSearchGames?.queryItems = [
                URLQueryItem(name: "key", value: ApiService.apiKey),
                URLQueryItem(name: "search", value: request)
            ]
            
            if let urlRequest = urlSearchGames?.url {
                let request = URLRequest(url: urlRequest)
                
                AF.request(request).validate().responseDecodable(of: GamesResponse.self) {
                    response in
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
