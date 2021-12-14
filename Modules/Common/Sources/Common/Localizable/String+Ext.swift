//
//  File.swift
//  
//
//  Created by Alfa Centaury on 14/12/21.
//

import Foundation

extension String {
    public func localized() -> String {
        return NSLocalizedString(self, bundle: .module, comment: "")
    }
}
