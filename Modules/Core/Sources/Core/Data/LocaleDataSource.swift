//
//  File.swift
//  
//
//  Created by Alfa Centaury on 03/12/21.
//

import Combine

public protocol LocaleDataSource {
    associatedtype Request
    associatedtype Response
    
    func getAllList(request: Request?) -> AnyPublisher<[Response], Error>
    
    func getById(_ id: Int) -> AnyPublisher<Response, Error>
    
    func set(_ entity: Response) -> AnyPublisher<Bool, Error>
    
    func deleteAll(request: Request?) -> AnyPublisher<Bool, Error>
    
    func deleteById(_ id: Int) -> AnyPublisher<Bool, Error>
    
    func loadUserDefault() -> AnyPublisher<Response, Error>
}
