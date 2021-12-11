//
//  File.swift
//  
//
//  Created by Alfa Centaury on 09/12/21.
//

import Foundation

public protocol LocaleMapper {
    associatedtype Entity
    associatedtype Domain
    
    func transformEntityToDomain(entity: Entity) -> Domain
    func transfomDomainToEntity(domain: Domain) -> Entity
}
