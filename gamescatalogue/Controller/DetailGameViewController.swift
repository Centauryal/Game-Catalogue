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
    
    var idDetailGame: Int = 0
    var idDetailFavorite: Int = 0
    private var detailGame: DetailGameResponse?
    private var detailFavoriteGame: GameModel?
    private var isFavorited: Bool = false
    
    private var service: ApiService?
    private lazy var gameProvider: GameProvider = { return GameProvider() }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        showFormatUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setNeedsStatusBarAppearanceUpdate()
        if idDetailGame != 0 {
            getDetailGame(id: String(idDetailGame))
            loadIDFavorite(idDetailGame)
        } else {
            loadIDFavorite(idDetailFavorite)
        }
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        .lightContent
    }
    
    private func getDetailGame(id: String) {
        service = ApiService()
        service?.getDetailGame(idDetail: id) { result in
            DispatchQueue.main.async {
                self.viewLoading.isHidden = true
                self.setupNavigationView(self.isFavorited)
                self.detailGame = result
                self.showUI(detailGame: result)
            }
        }
    }
    
    private func setupNavigationView(_ isFavorited: Bool) {
        let iconFavorite: UIImage?
        
        if isFavorited {
            iconFavorite = UIImage(systemName: "heart.fill")
        } else {
            iconFavorite = UIImage(systemName: "heart")
        }
        let btnFavorite = UIBarButtonItem(image: iconFavorite, style: .plain, target: self, action: #selector(favoriteTapped(tapGesture:)))
        self.navigationItem.rightBarButtonItem = btnFavorite
    }
    
    @objc func favoriteTapped(tapGesture: UITapGestureRecognizer) {
        if isFavorited {
            if idDetailGame != 0 {
                deleteFavorite(idDetailGame)
            } else {
                deleteFavorite(idDetailFavorite)
            }
        } else {            
            if idDetailGame != 0 {
                addFavorite(detailGame!)
            } else {
                addFavorite(detailFavoriteGame!)
            }
        }
        
        isFavorited = !isFavorited
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
        labelRatingBar.text = String(detailGame.rating) == "0.0" ? "No Rating" : String(detailGame.rating)
        
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
    }
    
    private func showFavoriteUI(detailGame: GameModel) {
        guard let imageFav = detailGame.image, let ratingFav = detailGame.rating, let desc = detailGame.desc?.utf8 else { return }
        
        ivBackgroundDetailGame.sd_setImage(
            with: URL(string: detailGame.imageBackground ?? imageFav),
            placeholderImage: UIImage(named: "brokenimage"))
        
        ivDetailGame.sd_setImage(with: URL(string: imageFav), placeholderImage: UIImage(named: "brokenimage"))
        
        labelGenre.text = detailGame.genre
        labelTitle.text = detailGame.name
        labelPublisher.text = detailGame.publisher
        labelReleaseDate.text = detailGame.releaseDate
        labelPlatform.text = detailGame.platform
        
        let starRating = StarRatingView(
            frame: CGRect(origin: .zero, size: CGSize(width: viewRatingBar.bounds.width, height: viewRatingBar.bounds.height)),
            rating: Float(ratingFav),
            color: .systemOrange,
            starRounding: .roundToHalfStar)
        viewRatingBar.addSubview(starRating)
        labelRatingBar.text = String(ratingFav) == "0.0" ? "No Rating" : String(detailGame.rating ?? 0.0)
        
        let html = NSAttributedString.DocumentType.html
        if let atrStr = try? NSAttributedString(data: Data(desc), options: [.documentType: html], documentAttributes: nil) {
            labelDesc.text = atrStr.string
        }
        
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
    
    private func loadIDFavorite(_ id: Int) {
        gameProvider.getFavoriteGame(id) { game in
            DispatchQueue.main.async {
                self.viewLoading.isHidden = true
                self.isFavorited = true
                self.setupNavigationView(self.isFavorited)
                
                if self.idDetailGame == 0 {
                    self.detailFavoriteGame = game
                    self.showFavoriteUI(detailGame: game)
                }
            }
        }
    }
    
    private func addFavorite(_ detail: DetailGameResponse) {
        guard let genre = labelGenre.text, let platform = labelPlatform.text, let publisher = labelPublisher.text else { return }
        
        gameProvider.setFavoriteGame(
            detail.id,
            detail.name,
            detail.backgroundImage,
            detail.backgroundImageAdditional ?? detail.backgroundImage,
            detail.description,
            detail.released,
            "\(genre)",
            "\(platform)",
            "\(publisher)",
            detail.rating) {
            DispatchQueue.main.async {
                self.setupNavigationView(self.isFavorited)
                self.showToast("Added to favorite")
            }
        }
    }
    
    private func addFavorite(_ detail: GameModel) {
        guard let genre = labelGenre.text, let platform = labelPlatform.text, let publisher = labelPublisher.text else { return }
        
        gameProvider.setFavoriteGame(
            Int(detail.id!),
            detail.name!,
            detail.image!,
            detail.imageBackground ?? detail.image!,
            detail.desc!,
            detail.releaseDate!,
            "\(genre)",
            "\(platform)",
            "\(publisher)",
            detail.rating!) {
            DispatchQueue.main.async {
                self.setupNavigationView(self.isFavorited)
                self.showToast("Added to favorite")
            }
        }
    }
    
    private func deleteFavorite(_ id: Int) {
        gameProvider.deleteFavoriteGame(id) {
            DispatchQueue.main.async {
                self.setupNavigationView(self.isFavorited)
                self.showToast("Removed from favorite")
            }
        }
    }
}
