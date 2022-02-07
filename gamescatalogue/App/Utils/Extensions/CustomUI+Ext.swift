//
//  Extension.swift
//  gamescatalogue
//
//  Created by Alfa Centaury on 27/08/21.
//

import UIKit
import SkeletonView

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

extension UIViewController {
    func showToast(_ message: String) {
        let toastLabel = UILabel(frame: CGRect(x: self.view.frame.size.width / 2 - 115, y: self.view.frame.size.height - 100, width: 210, height: 35))
        toastLabel.clipsToBounds  =  true
        toastLabel.backgroundColor = .darkGray
        toastLabel.textColor = .white
        toastLabel.textAlignment = .center
        toastLabel.text = message
        toastLabel.alpha = 1.0
        toastLabel.layer.cornerRadius = 10
        self.view.addSubview(toastLabel)
        
        UIView.animate(withDuration: 5.0, delay: 0.1, options: .curveEaseOut, animations: {
            toastLabel.alpha = 0.0
        }, completion: {(_) in
            toastLabel.removeFromSuperview()
        })
    }
    
    func outputReleaseDateString(date: String) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        let firstDate = formatter.date(from: date)!
        formatter.dateFormat = "dd MMMM yyyy"
        return formatter.string(from: firstDate)
    }
    
    func showViewLoading(_ view: UIView, _ show: Bool) {
        if show {
            view.isSkeletonable = true
            view.showAnimatedGradientSkeleton(transition: .crossDissolve(0.25))
        } else {
            DispatchQueue.main.async {
                view.stopSkeletonAnimation()
                self.view.hideSkeleton(reloadDataAfter: true, transition: .crossDissolve(0.25))
            }
        }
    }

    func showViewEmptyState (_ view: UIView, _ show: Bool) {
        DispatchQueue.main.async {
            view.isHidden = show ? false : true
        }
    }
}
