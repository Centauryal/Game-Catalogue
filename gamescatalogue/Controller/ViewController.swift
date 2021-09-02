//
//  ViewController.swift
//  gamescatalogue
//
//  Created by Alfa Centaury on 27/08/21.
//

import UIKit
import SDWebImage

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var tbGames: UITableView!
    @IBOutlet weak var viewLoading: UIView!
    
    private let ivAccount = UIImageView(image: UIImage(systemName: "person.crop.circle.fill"))
    private var listGames: [ResultsGames] = []
    private var service: ApiService?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.backButtonTitle = "Back"
        
        showUI()
        getListTeams()
        setupUIAccount()
    }
    
    private func showUI() {
        tbGames.dataSource = self
        tbGames.delegate = self
        tbGames.register(UINib(nibName: "GamesTableViewCell", bundle: nil), forCellReuseIdentifier: "gamesTableViewCell")
    }
    
    private func getListTeams() {
        service = ApiService()
        service?.getListGames { result in
            self.showViewLoading(true)
            if result.isEmpty {
                self.showViewLoading(false)
            } else {
                self.listGames = result
                
                DispatchQueue.main.async {
                    self.showViewLoading(false)
                    self.tbGames.reloadData()
                }
            }
        }
    }
    
    private func showViewLoading(_ show: Bool) {
        DispatchQueue.main.async {
            self.viewLoading.isHidden = show ? false : true
        }
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        guard let height = navigationController?.navigationBar.frame.height else { return }
        moveAndResizeImageAccount(for: height)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        showImage(true)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        showImage(false)
    }
    
    private func setupUIAccount() {
        guard let navigationBar = self.navigationController?.navigationBar else { return }
        navigationBar.addSubview(ivAccount)
        ivAccount.layer.cornerRadius = Const.ImageSizeForLargeState / 2
        ivAccount.clipsToBounds = true
        ivAccount.translatesAutoresizingMaskIntoConstraints = false
        ivAccount.tintColor = UIColor(named: "PrimaryColor")
        NSLayoutConstraint.activate([
            ivAccount.rightAnchor.constraint(equalTo: navigationBar.rightAnchor, constant: -Const.ImageRightMargin),
            ivAccount.bottomAnchor.constraint(equalTo: navigationBar.bottomAnchor, constant: -Const.ImageBottomMarginForLargeState),
            ivAccount.heightAnchor.constraint(equalToConstant: Const.ImageSizeForLargeState),
            ivAccount.widthAnchor.constraint(equalTo: ivAccount.heightAnchor)
            ])
        
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(imageTapped(tapGestureRecognizer:)))
        ivAccount.isUserInteractionEnabled = true
        ivAccount.addGestureRecognizer(tapGestureRecognizer)
    }
    
    @objc func imageTapped(tapGestureRecognizer: UITapGestureRecognizer) {
        if let account = self.storyboard?.instantiateViewController(identifier: "AccountViewController") as? AccountViewController {
            self.navigationController?.pushViewController(account, animated: true)
        }
    }
    
    private struct Const {
        static let ImageSizeForLargeState: CGFloat = 40
        static let ImageRightMargin: CGFloat = 16
        static let ImageBottomMarginForLargeState: CGFloat = 12
        static let ImageBottomMarginForSmallState: CGFloat = 6
        static let ImageSizeForSmallState: CGFloat = 32
        static let NavBarHeightSmallState: CGFloat = 44
        static let NavBarHeightLargeState: CGFloat = 96.5
    }
    
    private func showImage(_ show: Bool) {
        UIView.animate(withDuration: 0.2) {
            self.ivAccount.alpha = show ? 1.0 : 0.0
        }
    }
    
    private func moveAndResizeImageAccount(for height: CGFloat) {
        let coeff: CGFloat = {
            let delta = height - Const.NavBarHeightSmallState
            let heightDifferenceBetweenStates = (Const.NavBarHeightLargeState - Const.NavBarHeightSmallState)
            return delta / heightDifferenceBetweenStates
        }()

        let factor = Const.ImageSizeForSmallState / Const.ImageSizeForLargeState

        let scale: CGFloat = {
            let sizeAddendumFactor = coeff * (1.0 - factor)
            return min(1.0, sizeAddendumFactor + factor)
        }()

        let sizeDiff = Const.ImageSizeForLargeState * (1.0 - factor)
        let yTranslation: CGFloat = {
            let maxYTranslation = Const.ImageBottomMarginForLargeState - Const.ImageBottomMarginForSmallState + sizeDiff
            return max(0, min(maxYTranslation, (maxYTranslation - coeff * (Const.ImageBottomMarginForSmallState + sizeDiff))))
        }()

        let xTranslation = max(0, sizeDiff - coeff * sizeDiff)

        ivAccount.transform = CGAffineTransform.identity.scaledBy(x: scale, y: scale).translatedBy(x: xTranslation, y: yTranslation)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listGames.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let game: ResultsGames
        
        if let cell = tableView.dequeueReusableCell(withIdentifier: "gamesTableViewCell", for: indexPath) as? GamesTableViewCell {
            game = listGames[indexPath.row]
            
            cell.ivGame.sd_setImage(with: URL(string: game.backgroundImage), placeholderImage: UIImage(named: "brokenimage"))
            
            var listGenre = [String]()
            let genres = game.genres
            if genres.count > 2 {
                let genre = Array(genres[..<2])
                genre.forEach { genre in
                    listGenre.append(genre.name)
                }
                cell.labelGenre.text = listGenre.joined(separator: ", ")
            } else {
                genres.forEach { genre in
                    cell.labelGenre.text = genre.name
                }
            }
            
            cell.labelTitle.text = game.name
            
            var listPlatform = [String]()
            let platforms = game.platforms
            platforms.forEach { platform in
                listPlatform.append(platform.platform.name)
            }
            cell.labelPlatform.text = listPlatform.joined(separator: ", ")
            
            cell.labelRatingBar.text = String(game.rating)
            
            let formatter = DateFormatter()
            cell.labelReleaseDate.text = formatter.outputReleaseDateString(date: game.released)
            
            return cell
        } else {
            return UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tbGames.deselectRow(at: indexPath, animated: true)
        
        if let detail = self.storyboard?.instantiateViewController(identifier: "DetailGameViewController") as? DetailGameViewController {
            detail.idDetailGame = listGames[indexPath.row].id
            self.navigationController?.pushViewController(detail, animated: true)
        }
    }
}
