//
//  Account.swift
//  gamescatalogue
//
//  Created by Alfa Centaury on 20/11/21.
//

import Foundation

public struct Account: Equatable {
    public init(name: String,
                image: Data,
                desc: String) {
        self.name = name
        self.image = image
        self.desc = desc
    }
    
    public let name: String
    public let image: Data
    public let desc: String
}
