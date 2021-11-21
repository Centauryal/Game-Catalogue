//
//  RemoteDataSource.swift
//  gamescatalogue
//
//  Created by Alfa Centaury on 05/11/21.
//

import Foundation
import Alamofire
import Combine

protocol RemoteDataSourceProtocol: AnyObject {
    func getListGames() -> AnyPublisher<[ResultsGames], Error>
    
    func getDetailGame(idDetail id: String) -> AnyPublisher<DetailGameResponse, Error>
}

final class RemoteDataSource: NSObject {
    private override init() { }
    
    static let sharedInstance: RemoteDataSource = RemoteDataSource()
}

extension RemoteDataSource: RemoteDataSourceProtocol {
    func getListGames() -> AnyPublisher<[ResultsGames], Error> {
        return Future<[ResultsGames], Error> { completion in
            var urlListGames = URLComponents(string: Endpoints.Gets.listGames.urlEndpoint)
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
    
    func getDetailGame(idDetail id: String) -> AnyPublisher<DetailGameResponse, Error> {
        return Future<DetailGameResponse, Error> { completion in
            var urlDetailGame = URLComponents(string: Endpoints.Gets.detailGame.urlEndpoint + id)
            
            urlDetailGame?.queryItems = [
                URLQueryItem(name: "key", value: ApiService.apiKey)
            ]
            
            if let urlRequest = urlDetailGame?.url {
                let request = URLRequest(url: urlRequest)
                
                AF.request(request).validate().responseDecodable(of: DetailGameResponse.self) { response in
                    switch response.result {
                    case .success(let value):
                        completion(.success(value))
                    case .failure:
                        completion(.failure(URLError.invalidResponse))
                    }
                }
            }
        }.eraseToAnyPublisher()
    }
}
