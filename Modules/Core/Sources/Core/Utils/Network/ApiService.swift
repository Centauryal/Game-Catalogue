//
//  File.swift
//  
//
//  Created by Alfa Centaury on 07/12/21.
//

import Foundation

public struct ApiService {
    private func filePath() -> String {
        guard let path = Bundle.main.path(forResource: "GamesCatalogue-Info", ofType: "plist") else {
            fatalError("Couldn't find file 'GamesCatalogue-Info.plist'.")
        }
        return path
    }
    
    public static var apiKey: String {
        let plist = NSDictionary(contentsOfFile: ApiService().filePath())
        guard let value = plist?.object(forKey: "API_KEY") as? String else {
            fatalError("Couldn't find key 'API_KEY' in 'GamesCatalogue-Info.plist'.")
        }
        
        if value.starts(with: "_") {
            fatalError("Register for a RAWG.IO Developer Account")
        }
        return value
    }
    
    public static var baseUrl: String {
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

public protocol Endpoint {
    var urlEndpoint: String { get }
    
}

public enum Endpoints {
    public enum Gets: Endpoint {
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
