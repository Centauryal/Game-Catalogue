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

public struct GetGameDetailRemoteData: RemoteDataSource {
    public typealias Request = String
    public typealias Response = DetailGameResponse
    
    private let _endpoint: String
    
    public init(endpoint: String) {
        _endpoint = endpoint
    }
    
    public func execute(request: String?) -> AnyPublisher<DetailGameResponse, Error> {
        return Future<DetailGameResponse, Error> { completion in
            var urlDetailGame = URLComponents(string: _endpoint + request!)
            
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
