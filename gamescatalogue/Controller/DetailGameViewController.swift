//
//  DetailGameViewController.swift
//  gamescatalogue
//
//  Created by Alfa Centaury on 27/08/21.
//

import UIKit

class DetailGameViewController: UIViewController {

    @IBOutlet weak var ivBackgroundDetailGame: UIImageView!
    @IBOutlet weak var viewGradient: UIView!
    @IBOutlet weak var ivDetailGame: UIImageView!
    @IBOutlet weak var viewGenre: UIView!
    @IBOutlet weak var labelGenre: UILabel!
    @IBOutlet weak var labelTitle: UILabel!
    @IBOutlet weak var labelPublisher: UILabel!
    @IBOutlet weak var viewRatingBar: UIView!
    @IBOutlet weak var labelRatingBar: UILabel!
    @IBOutlet weak var labelReleaseDate: UILabel!
    @IBOutlet weak var overview: UILabel!
    @IBOutlet weak var labelDesc: UILabel!
    @IBOutlet weak var platform: UILabel!
    @IBOutlet weak var labelPlatform: UILabel!
    @IBOutlet weak var viewLoading: UIView!
    
    var idDetailGame: Int?
    private var service: ApiService?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getDetailGame(id: String(idDetailGame!))
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setNeedsStatusBarAppearanceUpdate()
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        .lightContent
    }
    
    private func getDetailGame(id: String) {
        service = ApiService()
        service?.getDetailGame(idDetail: id) { result in
            DispatchQueue.main.async {
                self.viewLoading.isHidden = true
                self.showUI(detailGame: result)
            }
        }
    }
    
    private func showUI(detailGame: DetailGameResponse) {
        ivBackgroundDetailGame.sd_setImage(
            with: URL(string: detailGame.backgroundImageAdditional ?? detailGame.backgroundImage),
            placeholderImage: UIImage(named: "brokenimage"))
        
        ivDetailGame.sd_setImage(with: URL(string: detailGame.backgroundImage), placeholderImage: UIImage(named: "brokenimage"))
        
        var listGenre = [String]()
        let genres = detailGame.genres
        if genres.count > 2 {
            let genre = Array(genres[..<2])
            genre.forEach { genre in
                listGenre.append(genre.name)
            }
            labelGenre.text = listGenre.joined(separator: ", ")
        } else {
            genres.forEach { genre in
                labelGenre.text = genre.name
            }
        }
        
        labelTitle.text = detailGame.name
        
        var listPublishers = [String]()
        let publisher = detailGame.publishers
        publisher.forEach { publish in
            listPublishers.append(publish.name)
        }
        labelPublisher.text = listPublishers.joined(separator: ", ")
        
        let starRating = StarRatingView(
            frame: CGRect(origin: .zero, size: CGSize(width: viewRatingBar.bounds.width, height: viewRatingBar.bounds.height)),
            rating: Float(detailGame.rating),
            color: .systemOrange,
            starRounding: .roundToHalfStar)
        viewRatingBar.addSubview(starRating)
        labelRatingBar.text = String(detailGame.rating)
        
        let formatter = DateFormatter()
        labelReleaseDate.text = formatter.outputReleaseDateString(date: detailGame.released)
        
        let desc = Data(detailGame.description.utf8)
        if let atrStr = try? NSAttributedString(data: desc, options: [.documentType: NSAttributedString.DocumentType.html], documentAttributes: nil) {
            labelDesc.text = atrStr.string
        }
        
        var listPlatform = [String]()
        let platforms = detailGame.platforms
        platforms.forEach { platform in
            listPlatform.append(platform.platform.name)
        }
        labelPlatform.text = listPlatform.joined(separator: ", ")
        
        showFormatUI()
    }
    
    private func showFormatUI() {
        viewGradient.addGradientBackground(
            firstColor: .white,
            secondColor: UIColor(red: 61/255, green: 178/255, blue: 255/255, alpha: 1),
            location: [0, 1])
        
        ivDetailGame.mainImage()
        
        viewGenre.layer.cornerRadius = 8
        
        labelTitle.font = UIFont.preferredFont(forTextStyle: .title2).bold()
        labelTitle.sizeToFit()
        
        labelRatingBar.font = UIFont.preferredFont(forTextStyle: .subheadline).bold()
        
        overview.font = UIFont.preferredFont(forTextStyle: .title1).bold()
        labelDesc.sizeToFit()
        
        platform.font = UIFont.preferredFont(forTextStyle: .title1).bold()
        
        labelPlatform.font = UIFont.preferredFont(forTextStyle: .body).bold()
        labelPlatform.sizeToFit()
    }
}
