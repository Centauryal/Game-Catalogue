//
//  ViewController.swift
//  gamescatalogue
//
//  Created by Alfa Centaury on 27/08/21.
//

import UIKit
import SDWebImage

class ViewController: UIViewController {

    @IBOutlet weak var tbGames: UITableView!
    @IBOutlet weak var viewLoading: UIView!
    
    private let ivAccount = UIImageView(image: UIImage(systemName: "person.crop.circle.fill"))
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.backButtonTitle = "Back"
    }


}

