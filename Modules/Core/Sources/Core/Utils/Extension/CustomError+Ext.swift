//
//  File.swift
//  
//
//  Created by Alfa Centaury on 06/12/21.
//

import Foundation

public enum URLError: LocalizedError {
    case invalidResponse
    case addressUnreachable(URL)
    
    public var errorDescription: String? {
        switch self {
        case .invalidResponse: return "The server responded with garbage."
        case .addressUnreachable(let urlEndpoint): return "\(urlEndpoint.absoluteString) is unreachable."
        }
    }
}

public enum LocaleError: LocalizedError {
    case invalidInstance
    case requestFailed
    
    public var errorDescription: String? {
        switch self {
        case .invalidInstance: return "Database can't instance."
        case .requestFailed: return "Your request failed."
        }
    }
}
