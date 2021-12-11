//
//  File.swift
//  
//
//  Created by Alfa Centaury on 03/12/21.
//

import Combine

public protocol Repository {
    associatedtype Request
    associatedtype Response
    
    func execute(request: Request?) -> AnyPublisher<Response, Error>
}
