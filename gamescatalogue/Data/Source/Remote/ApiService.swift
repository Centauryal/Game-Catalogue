//
//  ApiService.swift
//  gamescatalogue
//
//  Created by Alfa Centaury on 28/08/21.
//

import Foundation

struct ApiService {
    private func filePath() -> String {
        guard let path = Bundle.main.path(forResource: "GamesCatalogue-Info", ofType: "plist") else {
            fatalError("Couldn't find file 'GamesCatalogue-Info.plist'.")
        }
        return path
    }
    
    static var apiKey: String {
        let plist = NSDictionary(contentsOfFile: ApiService().filePath())
        guard let value = plist?.object(forKey: "API_KEY") as? String else {
            fatalError("Couldn't find key 'API_KEY' in 'GamesCatalogue-Info.plist'.")
        }
        
        if value.starts(with: "_") {
            fatalError("Register for a RAWG.IO Developer Account")
        }
        return value
    }
    
    static var baseUrl: String {
        let plist = NSDictionary(contentsOfFile: ApiService().filePath())
        guard let value = plist?.object(forKey: "BASE_URL") as? String else {
            fatalError("Couldn't find key 'BASE_URL' in 'GamesCatalogue-Info.plist'.")
        }
        
        if value.starts(with: "_") {
            fatalError("Cek Your Base URL")
        }
        return value
    }
}

protocol Endpoint {
    var urlEndpoint: String { get }
    
}

enum Endpoints {
    enum Gets: Endpoint {
        case listGames
        case detailGame
        
        public var urlEndpoint: String {
            switch self {
            case .listGames: return "\(ApiService.baseUrl)games"
            case .detailGame: return "\(ApiService.baseUrl)games/"
            }
        }
    }
}
