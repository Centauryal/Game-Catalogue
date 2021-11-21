//
//  RemoteDataSource.swift
//  gamescatalogue
//
//  Created by Alfa Centaury on 05/11/21.
//

import Foundation
import Alamofire
import RxSwift

protocol RemoteDataSourceProtocol: AnyObject {
    func getListGames() -> Observable<[ResultsGames]>
    
    func getDetailGame(idDetail id: String) -> Observable<DetailGameResponse>
}

final class RemoteDataSource: NSObject {
    private override init() { }
    
    static let sharedInstance: RemoteDataSource = RemoteDataSource()
}

extension RemoteDataSource: RemoteDataSourceProtocol {
    func getListGames() -> Observable<[ResultsGames]> {
        return Observable<[ResultsGames]>.create { observer in
            var urlListGames = URLComponents(string: Endpoints.Gets.listGames.urlEndpoint)
            urlListGames?.queryItems = [
                URLQueryItem(name: "key", value: ApiService.apiKey)
            ]
            
            if let urlRequest = urlListGames?.url {
                let request = URLRequest(url: urlRequest)
                
                AF.request(request).validate().responseDecodable(of: GamesResponse.self) { response in
                    switch response.result {
                    case .success(let value):
                        observer.onNext(value.results)
                        observer.onCompleted()
                    case .failure:
                        observer.onError(URLError.invalidResponse)
                    }
                }
            }
            
            return Disposables.create()
        }
    }
    
    func getDetailGame(idDetail id: String) -> Observable<DetailGameResponse> {
        return Observable<DetailGameResponse>.create { observer in
            var urlDetailGame = URLComponents(string: Endpoints.Gets.detailGame.urlEndpoint + id)
            
            urlDetailGame?.queryItems = [
                URLQueryItem(name: "key", value: ApiService.apiKey)
            ]
            
            if let urlRequest = urlDetailGame?.url {
                let request = URLRequest(url: urlRequest)
                
                AF.request(request).validate().responseDecodable(of: DetailGameResponse.self) { response in
                    switch response.result {
                    case .success(let value):
                        observer.onNext(value)
                        observer.onCompleted()
                    case .failure:
                        observer.onError(URLError.invalidResponse)
                    }
                }
            }
            
            return Disposables.create()
        }
    }
}
