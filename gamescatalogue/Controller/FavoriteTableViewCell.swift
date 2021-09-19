//
//  FavoriteTableViewCell.swift
//  gamescatalogue
//
//  Created by Alfa Centaury on 13/09/21.
//

import UIKit

class FavoriteTableViewCell: UITableViewCell {

    @IBOutlet weak var cardView: UIView!
    @IBOutlet weak var ivFavorite: UIImageView!
    @IBOutlet weak var viewGenre: UIView!
    @IBOutlet weak var labelGenre: UILabel!
    @IBOutlet weak var labelTitle: UILabel!
    @IBOutlet weak var labelPlatform: UILabel!
    @IBOutlet weak var labelReleaseDate: UILabel!
    @IBOutlet weak var labelRatingBar: UILabel!
    @IBOutlet weak var btnDelete: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        showUI()
    }
    
    private func showUI() {
        cardView.layer.cornerRadius = 10
        cardView.layer.borderColor = UIColor.lightGray.cgColor
        cardView.layer.borderWidth = 1
        
        viewGenre.layer.cornerRadius = 8
        
        ivFavorite.mainImage()
        ivFavorite.layer.shadowPath = UIBezierPath(rect: ivFavorite.bounds).cgPath
        ivFavorite.layer.shouldRasterize = true
        ivFavorite.layer.rasterizationScale = UIScreen.main.scale
        
        labelTitle.font = UIFont.preferredFont(forTextStyle: .title3).bold()
        labelTitle.sizeToFit()
        labelPlatform.sizeToFit()
        
        labelRatingBar.font = UIFont.preferredFont(forTextStyle: .caption2).bold()
        
        labelReleaseDate.font = UIFont.preferredFont(forTextStyle: .caption2).bold()
        labelReleaseDate.sizeToFit()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 15, left: 20, bottom: 10, right: 20))
    }
    
}
