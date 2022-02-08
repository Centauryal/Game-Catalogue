//
//  FavoriteViewController.swift
//  gamescatalogue
//
//  Created by Alfa Centaury on 13/09/21.
//

import UIKit
import Favorite
import Common
import SkeletonView

class FavoriteViewController: UIViewController {

    @IBOutlet weak var tbFavorite: UITableView!
    @IBOutlet weak var viewEmptyState: EmptyStateView!
    
    private var listFavorite: [GameDB] = []
    var presenter: FavoritePresenter?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.backButtonTitle = "btn_back".localized()

        showUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        loadAllFavorites()
    }
    
    private func showUI() {
        tbFavorite.rowHeight = UITableView.automaticDimension
        tbFavorite.estimatedRowHeight = 200
        tbFavorite.dataSource = self
        tbFavorite.delegate = self
        tbFavorite.register(UINib(nibName: "FavoriteTableViewCell", bundle: nil), forCellReuseIdentifier: "favoriteTableViewCell")
        
        viewEmptyState.textTitle = "text_no_favorite".localized()
    }
    
    private func loadAllFavorites() {
        presenter?.getAllFavorite(
            receiveCompletion: { completion in
                switch completion {
                case .finished:
                    self.showViewLoading(self.tbFavorite, false)
                case .failure:
                    self.showToast(String(describing: completion))
                }
            }, receiveValue: { favorites in
                if favorites.isEmpty {
                    self.showViewEmptyState(self.viewEmptyState, true)
                } else {
                    self.listFavorite = favorites
                    self.tbFavorite.reloadData()
                }
            })
    }
    
    @objc func deleteFavoriteTapped(_ sender: UIButton, tapGesture: UITapGestureRecognizer) {
        let alert = UIAlertController(title: "alert_title_delete".localized(), message: "alert_message_delete".localized(), preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "btn_delete".localized(), style: .destructive, handler: { _ in
            self.deleteFavorite(sender.tag)
        }))
        let cancelAlert = UIAlertAction(title: "btn_cancel".localized(), style: .cancel, handler: nil)
        cancelAlert.setValue(UIColor(named: "AccentColor"), forKey: "titleTextColor")
        alert.addAction(cancelAlert)

        self.present(alert, animated: true, completion: nil)
    }
    
    private func deleteFavorite(_ id: Int) {
        showViewLoading(tbFavorite, true)
        
        presenter?.deleteFavorite(id,
           receiveCompletion: { completion in
            switch completion {
            case .finished:
                self.showToast("remove_favorite".localized())
            case .failure:
                self.showToast(String(describing: completion))
            }
        }, receiveValue: {_ in
            self.loadAllFavorites()
        })
    }
}

extension FavoriteViewController: SkeletonTableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listFavorite.count
    }
    
    func collectionSkeletonView(_ skeletonView: UITableView, cellIdentifierForRowAt indexPath: IndexPath) -> ReusableCellIdentifier {
        return "favoriteTableViewCell"
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let favorite: GameDB
        
        if let cell = tableView.dequeueReusableCell(withIdentifier: "favoriteTableViewCell", for: indexPath) as? FavoriteTableViewCell {
            favorite = listFavorite[indexPath.row]
            
            cell.ivFavorite.sd_setImage(with: URL(string: favorite.image), placeholderImage: UIImage(named: "brokenimage"))
            
            cell.labelGenre.text = favorite.genre
            cell.labelTitle.text = favorite.name
            cell.labelPlatform.text = favorite.platform
            cell.labelReleaseDate.text = favorite.releaseDate
            cell.labelRatingBar.text = String(favorite.rating)
            
            cell.btnDelete.tag = Int(favorite.id)
            cell.btnDelete.addTarget(self, action: #selector(deleteFavoriteTapped(_:tapGesture:)), for: .touchUpInside)
            
            return cell
        } else {
            return UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tbFavorite.deselectRow(at: indexPath, animated: true)
        presenter?.favoriteToDetail(view: self, detailId: Int(listFavorite[indexPath.row].id))
    }
}
