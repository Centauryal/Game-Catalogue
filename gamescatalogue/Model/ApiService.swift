//
//  ApiService.swift
//  gamescatalogue
//
//  Created by Alfa Centaury on 28/08/21.
//

import Foundation

class ApiService {
    private let apiKey = "7af81184a1914691b6e48abafd1223d2"
    private let baseUrl = "https://api.rawg.io/api/"
    
    func getListGames(completion: @escaping ([ResultsGames]) -> Void) {
        var urlListGames = URLComponents(string: baseUrl + "games")!
        
        urlListGames.queryItems = [
            URLQueryItem(name: "key", value: apiKey)
        ]
        
        let request = URLRequest(url: urlListGames.url!)
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if error != nil {
                print("Failed: Some think wrong!")
            } else if let data = data, let response = response as? HTTPURLResponse, response.statusCode == 200 {
                let decoder = JSONDecoder()
                decoder.dateDecodingStrategy = .iso8601
                
                do {
                    let listGames = try decoder.decode(GamesResponse.self, from: data).results
                    completion(listGames)
                } catch {
                    print("Invalid Response \(error)")
                }
            }
        }
        task.resume()
    }
    
    func getDetailGame(idDetail id: String, completion: @escaping (DetailGameResponse) -> Void) {
        var urlDetailGame = URLComponents(string: baseUrl + "games/" + id)!
        
        urlDetailGame.queryItems = [
            URLQueryItem(name: "key", value: apiKey)
        ]
        
        let request = URLRequest(url: urlDetailGame.url!)
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if error != nil {
                print("Failed: Some think wrong!")
            } else if let data = data, let response = response as? HTTPURLResponse, response.statusCode == 200 {
                let decoder = JSONDecoder()
                decoder.dateDecodingStrategy = .iso8601
                
                do {
                    let game = try decoder.decode(DetailGameResponse.self, from: data)
                    completion(game)
                } catch {
                    print("Invalid Response \(error)")
                }
            }
        }
        task.resume()
    }
}
