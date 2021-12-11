//
//  DetailGameViewController.swift
//  gamescatalogue
//
//  Created by Alfa Centaury on 27/08/21.
//

import UIKit
import Games

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
    
    private var detailGame: Detail?
    private var detailFavoriteGame: GameDB?
    private var isFavorited: Bool = false
    
    var detailPresenter: DetailPresenter?
    var fromFavorite: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        showFormatUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setNeedsStatusBarAppearanceUpdate()
        if fromFavorite == 0 {
            getDetailGame()
        } else {
            loadIDFavorite()
        }
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        .lightContent
    }
    
    private func getDetailGame() {
        detailPresenter?.getDetailGame(
            receiveCompletion: { completion in
                switch completion {
                case .finished:
                    self.viewLoading.isHidden = true
                case .failure(_):
                    self.showToast(String(describing: completion))
                }
            },
            receiveValue: { detail in
                self.setupNavigationView(self.isFavorited)
                self.detailGame = detail
                self.showUI(detailGame: detail)
                self.loadIDFavorite()
            })
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
//        if isFavorited {
//            detailGame?.id != nil ? deleteFavorite() : deleteFavorite()
//        } else {
//            detailGame?.id != nil ? addFavorite(detailGame!) : addFavorite(detailFavoriteGame!)
//        }
        
        isFavorited = !isFavorited
    }
    
    private func showUI(detailGame: Detail) {
        ivBackgroundDetailGame.sd_setImage(
            with: URL(string:
                        detailGame.backgroundImageAdditional == "Unknown" ? detailGame.backgroundImage : detailGame.backgroundImageAdditional),
            placeholderImage: UIImage(named: "brokenimage"))

        ivDetailGame.sd_setImage(with: URL(string: detailGame.backgroundImage), placeholderImage: UIImage(named: "brokenimage"))

        var listGenre = [String]()
        let genres = detailGame.genres
        if genres.count > 2 {
            let genre = Array(genres[..<2])
            genre.forEach { listGenre.append($0) }
            labelGenre.text = listGenre.joined(separator: ", ")
        } else {
            genres.forEach { labelGenre.text = $0 }
        }

        labelTitle.text = detailGame.name

        var listPublishers = [String]()
        let publisher = detailGame.publishers
        publisher.forEach { listPublishers.append($0) }
        labelPublisher.text = listPublishers.joined(separator: ", ")

        let starRating = StarRatingView(
            frame: CGRect(origin: .zero, size: CGSize(width: viewRatingBar.bounds.width, height: viewRatingBar.bounds.height)),
            rating: Float(detailGame.rating),
            color: .systemOrange,
            starRounding: .roundToHalfStar)
        viewRatingBar.addSubview(starRating)
        labelRatingBar.text = String(detailGame.rating) == "0.0" ? "No Rating" : String(detailGame.rating)

        labelReleaseDate.text = outputReleaseDateString(date: detailGame.released)

        let desc = Data(detailGame.description.utf8)
        if let atrStr = try? NSAttributedString(data: desc, options: [.documentType: NSAttributedString.DocumentType.html], documentAttributes: nil) {
            labelDesc.text = atrStr.string
        }

        var listPlatform = [String]()
        let platforms = detailGame.platforms
        platforms.forEach { listPlatform.append($0) }
        labelPlatform.text = listPlatform.joined(separator: ", ")
    }
    
    private func showFavoriteUI(detailGame: GameDB) {
        ivBackgroundDetailGame.sd_setImage(
            with: URL(string: detailGame.imageBackground == "Unknown" ? detailGame.image : detailGame.imageBackground),
            placeholderImage: UIImage(named: "brokenimage"))
        
        ivDetailGame.sd_setImage(with: URL(string: detailGame.image), placeholderImage: UIImage(named: "brokenimage"))
        
        labelGenre.text = detailGame.genre
        labelTitle.text = detailGame.name
        labelPublisher.text = detailGame.publisher
        labelReleaseDate.text = detailGame.releaseDate
        labelPlatform.text = detailGame.platform
        
        let starRating = StarRatingView(
            frame: CGRect(origin: .zero, size: CGSize(width: viewRatingBar.bounds.width, height: viewRatingBar.bounds.height)),
            rating: Float(detailGame.rating),
            color: .systemOrange,
            starRounding: .roundToHalfStar)
        viewRatingBar.addSubview(starRating)
        labelRatingBar.text = String(detailGame.rating) == "0.0" ? "No Rating" : String(detailGame.rating)
        
        let html = NSAttributedString.DocumentType.html
        if let atrStr = try? NSAttributedString(
            data: Data(detailGame.desc.utf8),
            options: [.documentType: html],
            documentAttributes: nil) {
            
            labelDesc.text = atrStr.string
        }
        
    }
    
    private func showFormatUI() {
        viewGradient.addGradientBackground(
            firstColor: .white,
            secondColor: UIColor(named: "AccentColor") ?? .white,
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
    
    private func loadIDFavorite() {
//        detailPresenter?.getFavorite()
//            .receive(on: RunLoop.main)
//            .sink(receiveCompletion: { completion in
//                switch completion {
//                case .finished:
//                    self.viewLoading.isHidden = true
//                case .failure:
//                    self.showToast(String(describing: completion))
//                }
//            }, receiveValue: { favorite in
//                self.isFavorited = true
//                self.setupNavigationView(self.isFavorited)
//                if self.detailGame == nil {
//                    self.detailFavoriteGame = favorite
//                    self.showFavoriteUI(detailGame: favorite)
//                }
//            })
//            .store(in: &cancellables)
    }
    
//    private func addFavorite(_ detail: Detail) {
//        guard let genre = labelGenre.text, let platform = labelPlatform.text, let publisher = labelPublisher.text else { return }
//        
//        let favorite = GameDB(
//            id: Int32(detail.id),
//            name: detail.name,
//            image: detail.backgroundImage,
//            imageBackground: detail.backgroundImageAdditional == "Unknown" ? detail.backgroundImage : detail.backgroundImageAdditional,
//            desc: detail.description,
//            releaseDate: detail.released,
//            genre: genre,
//            platform: platform,
//            publisher: publisher,
//            rating: detail.rating)
//        
//        detailPresenter?.setFavorite(favorite)
//            .receive(on: RunLoop.main)
//            .sink(receiveCompletion: { completion in
//                switch completion {
//                case .finished:
//                    self.showToast("Added to favorite")
//                case .failure:
//                    self.showToast(String(describing: completion))
//                }
//            }, receiveValue: {_ in
//                self.setupNavigationView(self.isFavorited)
//            })
//            .store(in: &cancellables)
//    }
    
    private func addFavorite(_ detail: GameDB) {
//        detailPresenter?.setFavorite(detail)
//            .receive(on: RunLoop.main)
//            .sink(receiveCompletion: { completion in
//                switch completion {
//                case .finished:
//                    self.showToast("Added to favorite")
//                case .failure:
//                    self.showToast(String(describing: completion))
//                }
//            }, receiveValue: {_ in
//                self.setupNavigationView(self.isFavorited)
//            })
//            .store(in: &cancellables)
    }
    
    private func deleteFavorite() {
//        detailPresenter?.deleteFavorite()
//            .receive(on: RunLoop.main)
//            .sink(receiveCompletion: { completion in
//                switch completion {
//                case .finished:
//                    self.showToast("Removed from favorite")
//                case .failure:
//                    self.showToast(String(describing: completion))
//                }
//            }, receiveValue: {_ in
//                self.setupNavigationView(self.isFavorited)
//            })
//            .store(in: &cancellables)
    }
}
