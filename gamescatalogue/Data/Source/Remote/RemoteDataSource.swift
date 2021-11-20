//
//  RemoteDataSource.swift
//  gamescatalogue
//
//  Created by Alfa Centaury on 05/11/21.
//

import Foundation

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
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if error != nil {
                completion(.failure(.addressUnreachable(urlRequest)))
            } else if let data = data, let response = response as? HTTPURLResponse, response.statusCode == 200 {
                let decoder = JSONDecoder()
                decoder.dateDecodingStrategy = .iso8601
                
                do {
                    let listGames = try decoder.decode(GamesResponse.self, from: data).results
                    completion(.success(listGames))
                } catch {
                    completion(.failure(.invalidResponse))
                }
            }
        }
        task.resume()
    }
    
    func getDetailGame(idDetail id: String, completion: @escaping (Result<DetailGameResponse, URLError>) -> Void) {
        var urlDetailGame = URLComponents(string: Endpoints.Gets.detailGame.urlEndpoint + id)
        
        urlDetailGame?.queryItems = [
            URLQueryItem(name: "key", value: ApiService.apiKey)
        ]
        
        guard let urlRequest = urlDetailGame?.url else { return }
        let request = URLRequest(url: urlRequest)
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if error != nil {
                completion(.failure(.addressUnreachable(urlRequest)))
            } else if let data = data, let response = response as? HTTPURLResponse, response.statusCode == 200 {
                let decoder = JSONDecoder()
                decoder.dateDecodingStrategy = .iso8601
                
                do {
                    let game = try decoder.decode(DetailGameResponse.self, from: data)
                    completion(.success(game))
                } catch {
                    completion(.failure(.invalidResponse))
                }
            }
        }
        task.resume()
    }
}
