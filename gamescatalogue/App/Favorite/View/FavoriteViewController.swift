//
//  FavoriteViewController.swift
//  gamescatalogue
//
//  Created by Alfa Centaury on 13/09/21.
//

import UIKit
import RxSwift

class FavoriteViewController: UIViewController {

    @IBOutlet weak var tbFavorite: UITableView!
    @IBOutlet weak var viewLoading: UIView!
    @IBOutlet weak var viewEmptyState: UIView!
    @IBOutlet weak var labelEmptyState: UILabel!
    
    private var listFavorite: [GameDB] = []
    private let disposeBag = DisposeBag()
    var presenter: FavoritePresenter?
    
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
        showViewLoading(self.viewLoading, true)
        
        presenter?.getAllFavorite()
            .observe(on: MainScheduler.instance)
            .subscribe { result in
                if result.isEmpty {
                    showViewLoading(self.viewLoading, false)
                    showViewEmptyState(self.viewEmptyState, true)
                } else {
                    showViewLoading(self.viewLoading, false)
                    self.listFavorite = result
                    self.tbFavorite.reloadData()
                }
            } onError: { error in
                self.showToast(error.localizedDescription)
            } onCompleted: {
                showViewLoading(self.viewLoading, false)
            }.disposed(by: disposeBag)
    }
    
    @objc func deleteFavoriteTapped(_ sender: UIButton, tapGesture: UITapGestureRecognizer) {
        let alert = UIAlertController(title: "Delete Favorite", message: "Are you sure to delete this favorite?", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Delete", style: .destructive, handler: { _ in
            self.deleteFavorite(sender.tag)
        }))
        let cancelAlert = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        cancelAlert.setValue(UIColor(named: "AccentColor"), forKey: "titleTextColor")
        alert.addAction(cancelAlert)

        self.present(alert, animated: true, completion: nil)
    }
    
    private func deleteFavorite(_ id: Int) {
        presenter?.deleteFavorite(id)
            .observe(on: MainScheduler.instance)
            .subscribe {_ in
                self.loadAllFavorites()
            } onError: { error in
                self.showToast(error.localizedDescription)
            } onCompleted: {
                self.showToast("Removed from favorite")
            }.disposed(by: disposeBag)
    }
}

extension FavoriteViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listFavorite.count
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
