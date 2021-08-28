//
//  DetailBackgroundViewController.swift
//  gamescatalogue
//
//  Created by Alfa Centaury on 27/08/21.
//

import UIKit

class DetailBackgroundViewController: UIViewController {

    @IBOutlet weak var ivBackgroundDetail: UIImageView!
    @IBOutlet weak var viewGradient: UIView!
    
    var detailBackground: String = ""
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        showUI()
    }
    
    private func showUI() {
        ivBackgroundDetail.sd_setImage(
            with: URL(string: detailBackground),
            placeholderImage: UIImage(named: "brokenimage"))
        
        viewGradient.addGradientBackground(
            firstColor: .white,
            secondColor: UIColor(red: 216/255, green: 58/255, blue: 86/255, alpha: 1),
            location: [0, 1])
    }

}
