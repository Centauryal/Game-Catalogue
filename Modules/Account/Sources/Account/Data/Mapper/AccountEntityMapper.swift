//
//  File.swift
//  
//
//  Created by Alfa Centaury on 13/12/21.
//

import Core

public struct AccountEntityMapper: LocaleMapper {
    
    public typealias Entity = AccountModuleEntity
    public typealias Domain = Account
    
    public init() {}
    
    public func transformEntityToDomain(entity: AccountModuleEntity) -> Account {
        return Account(
            name: entity.name,
            image: entity.image,
            desc: entity.desc
        )
    }
    
    public func transfomDomainToEntity(domain: Account) -> AccountModuleEntity {
        return AccountModuleEntity(
            name: domain.name,
            image: domain.image,
            desc: domain.desc
        )
    }
}
