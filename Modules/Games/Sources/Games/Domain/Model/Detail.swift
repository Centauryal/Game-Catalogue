//
//  File.swift
//  
//
//  Created by Alfa Centaury on 07/12/21.
//

public struct Detail: Equatable, Identifiable {
    public let id: Int
    public let name: String
    public let description: String
    public let released: String
    public let backgroundImage: String
    public let backgroundImageAdditional: String
    public let rating: Double
    public let platforms: [String]
    public let genres: [String]
    public let publishers: [String]
}
