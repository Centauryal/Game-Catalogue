//
//  Extension.swift
//  gamescatalogue
//
//  Created by Alfa Centaury on 27/08/21.
//

import UIKit

extension UIFont {
    func withTraits(traits:UIFontDescriptor.SymbolicTraits) -> UIFont {
        let descriptor = fontDescriptor.withSymbolicTraits(traits)
        
        return UIFont(descriptor: descriptor!, size: 0)
    }

    func bold() -> UIFont {
        return withTraits(traits: .traitBold)
    }

    func italic() -> UIFont {
        return withTraits(traits: .traitItalic)
    }
}

extension UIImageView {
    func mainImage() {
        self.layer.cornerRadius = 10
        self.layer.borderColor = UIColor.lightGray.cgColor
        self.layer.borderWidth = 1
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOpacity = 0.2
        self.layer.shadowOffset = CGSize(width: 4, height: 4)
        self.layer.shadowRadius = 5.0
    }
}

extension UIView {
    func addGradientBackground(firstColor: UIColor, secondColor: UIColor, location: [NSNumber]) {
        clipsToBounds = true
        
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [firstColor.cgColor, secondColor.cgColor]
        gradientLayer.frame = CGRect(x: 0, y: 0, width: self.bounds.width, height: self.bounds.height)
        gradientLayer.locations = location
        
        self.layer.insertSublayer(gradientLayer, at: 0)
    }
}

extension DateFormatter {
    func outputReleaseDateString(date: String) -> String {
        self.dateFormat = "yyyy-MM-dd"
        let firstDate = self.date(from: date)!
        self.dateFormat = "dd MMMM yyyy"
        return self.string(from: firstDate)
    }
}
