//
//  RemoteDataSource.swift
//  gamescatalogue
//
//  Created by Alfa Centaury on 05/11/21.
//

import Foundation
import Alamofire

protocol RemoteDataSourceProtocol: AnyObject {
    func getListGames(completion: @escaping (Result<[ResultsGames], URLError>) -> Void)
    
    func getDetailGame(idDetail id: String, completion: @escaping (Result<DetailGameResponse, URLError>) -> Void)
}

final class RemoteDataSource: NSObject {
    private override init() { }
    
    static let sharedInstance: RemoteDataSource = RemoteDataSource()
}

extension RemoteDataSource: RemoteDataSourceProtocol {
    func getListGames(completion: @escaping (Result<[ResultsGames], URLError>) -> Void) {
        var urlListGames = URLComponents(string: Endpoints.Gets.listGames.urlEndpoint)
        urlListGames?.queryItems = [
            URLQueryItem(name: "key", value: ApiService.apiKey)
        ]
        
        guard let urlRequest = urlListGames?.url else { return }
        let request = URLRequest(url: urlRequest)
        
        AF.request(request).validate().responseDecodable(of: GamesResponse.self) { response in
            switch response.result {
            case .success(let value):
                completion(.success(value.results))
            case .failure:
                completion(.failure(.invalidResponse))
            }
        }
    }
    
    func getDetailGame(idDetail id: String, completion: @escaping (Result<DetailGameResponse, URLError>) -> Void) {
        var urlDetailGame = URLComponents(string: Endpoints.Gets.detailGame.urlEndpoint + id)
        
        urlDetailGame?.queryItems = [
            URLQueryItem(name: "key", value: ApiService.apiKey)
        ]
        
        guard let urlRequest = urlDetailGame?.url else { return }
        let request = URLRequest(url: urlRequest)
        
        AF.request(request).validate().responseDecodable(of: DetailGameResponse.self) { response in
            switch response.result {
            case .success(let value):
                completion(.success(value))
            case .failure:
                completion(.failure(.invalidResponse))
            }
        }
    }
}
