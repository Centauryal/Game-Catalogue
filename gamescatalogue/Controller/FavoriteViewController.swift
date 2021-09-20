//
//  FavoriteViewController.swift
//  gamescatalogue
//
//  Created by Alfa Centaury on 13/09/21.
//

import UIKit

class FavoriteViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var tbFavorite: UITableView!
    @IBOutlet weak var viewLoading: UIView!
    @IBOutlet weak var viewEmptyState: UIView!
    @IBOutlet weak var labelEmptyState: UILabel!
    
    private var listFavorite: [GameModel] = []
    private lazy var gameProvider: GameProvider = { return GameProvider() }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.backButtonTitle = "Back"

        showUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        loadAllFavorites()
    }
    
    private func showUI() {
        tbFavorite.dataSource = self
        tbFavorite.delegate = self
        tbFavorite.register(UINib(nibName: "FavoriteTableViewCell", bundle: nil), forCellReuseIdentifier: "favoriteTableViewCell")
        
        labelEmptyState.font = UIFont.preferredFont(forTextStyle: .title2).bold()
    }
    
    private func loadAllFavorites() {
        self.gameProvider.getAllFavoriteGames { result in
            DispatchQueue.main.async {
                showViewLoading(self.viewLoading, true)
                
                if result.isEmpty {
                    showViewLoading(self.viewLoading, false)
                    showViewEmptyState(self.viewEmptyState, true)
                } else {
                    showViewLoading(self.viewLoading, false)
                    self.listFavorite = result
                    self.tbFavorite.reloadData()
                }
            }
        }
    }
    
    @objc func deleteFavoriteTapped(_ sender: UIButton, tapGesture: UITapGestureRecognizer) {
        let alert = UIAlertController(title: "Delete Favorite", message: "Are you sure to delete this favorite?", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Delete", style: .destructive, handler: { _ in
            self.deleteFavorite(sender.tag)
        }))
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        
        self.present(alert, animated: true, completion: nil)
    }
    
    private func deleteFavorite(_ id: Int) {
        gameProvider.deleteFavoriteGame(id) {
            DispatchQueue.main.async {
                self.loadAllFavorites()
                self.showToast("Removed from favorite")
            }
        }
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listFavorite.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let favorite: GameModel
        
        if let cell = tableView.dequeueReusableCell(withIdentifier: "favoriteTableViewCell", for: indexPath) as? FavoriteTableViewCell {
            favorite = listFavorite[indexPath.row]
            
            cell.ivFavorite.sd_setImage(with: URL(string: favorite.image!), placeholderImage: UIImage(named: "brokenimage"))
            
            cell.labelGenre.text = favorite.genre
            cell.labelTitle.text = favorite.name
            cell.labelPlatform.text = favorite.platform
            cell.labelReleaseDate.text = favorite.releaseDate
            cell.labelRatingBar.text = String(favorite.rating!)
            
            cell.btnDelete.tag = Int(favorite.id!)
            cell.btnDelete.addTarget(self, action: #selector(deleteFavoriteTapped(_:tapGesture:)), for: .touchUpInside)
            
            return cell
        } else {
            return UITableViewCell()
        }
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tbFavorite.deselectRow(at: indexPath, animated: true)
        
        if let detail = self.storyboard?.instantiateViewController(identifier: "DetailGameViewController") as? DetailGameViewController {
            guard let id = listFavorite[indexPath.row].id else { return }
            detail.idDetailFavorite = Int("\(id)")!
            self.navigationController?.pushViewController(detail, animated: true)
        }
    }
}
