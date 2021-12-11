//
//  File.swift
//  
//
//  Created by Alfa Centaury on 06/12/21.
//

import Foundation

public protocol Mapper {
    associatedtype Response
    associatedtype Domain
    
    func transfomResponseToDomain(response: Response) -> Domain
}
