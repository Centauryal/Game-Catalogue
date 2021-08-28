//
//  DetailGameViewController.swift
//  gamescatalogue
//
//  Created by Alfa Centaury on 27/08/21.
//

import UIKit

class DetailGameViewController: UIViewController {

    @IBOutlet weak var ivDetailGame: UIImageView!
    @IBOutlet weak var viewGenre: UIView!
    @IBOutlet weak var labelGenre: UILabel!
    @IBOutlet weak var labelTitle: UILabel!
    @IBOutlet weak var labelPublisher: UILabel!
    @IBOutlet weak var labelReleaseDate: UILabel!
    @IBOutlet weak var overview: UILabel!
    @IBOutlet weak var labelDesc: UILabel!
    @IBOutlet weak var platform: UILabel!
    @IBOutlet weak var labelPlatform: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        showUI()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setNeedsStatusBarAppearanceUpdate()
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        .lightContent
    }
    
    private func showUI() {
        ivDetailGame.mainImage()
        
        viewGenre.layer.cornerRadius = 8
        
        labelTitle.font = UIFont.preferredFont(forTextStyle: .title2).bold()
        labelTitle.sizeToFit()
        
        overview.font = UIFont.preferredFont(forTextStyle: .title1).bold()
        labelDesc.sizeToFit()
        
        platform.font = UIFont.preferredFont(forTextStyle: .title1).bold()
        labelPlatform.sizeToFit()
    }

}
