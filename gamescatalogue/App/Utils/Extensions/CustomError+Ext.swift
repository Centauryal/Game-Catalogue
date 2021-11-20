//
//  CustomError+Ext.swift
//  gamescatalogue
//
//  Created by Alfa Centaury on 05/11/21.
//

import Foundation

enum URLError: LocalizedError {
    case invalidResponse
    case addressUnreachable(URL)
    
    var errorDescription: String? {
        switch self {
        case .invalidResponse: return "The server responded with garbage."
        case .addressUnreachable(let urlEndpoint): return "\(urlEndpoint.absoluteString) is unreachable."
        }
    }
}

enum LocaleError: LocalizedError {
    case invalidInstance
    case requestFailed
    
    var errorDescription: String? {
        switch self {
        case .invalidInstance: return "Database can't instance."
        case .requestFailed: return "Your request failed."
        }
    }
}
