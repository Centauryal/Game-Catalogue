//
//  ViewController.swift
//  gamescatalogue
//
//  Created by Alfa Centaury on 27/08/21.
//

import UIKit
import SDWebImage
import Games

class ViewController: UIViewController {

    @IBOutlet weak var tbGames: UITableView!
    @IBOutlet weak var viewLoading: UIView!
    @IBOutlet weak var viewEmptyState: UIView!
    @IBOutlet weak var labelEmptyState: UILabel!
    
    private var listGames: [Game] = []
    var presenter: HomePresenter?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.backButtonTitle = "Back"
        
        showUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getListTeams()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "favoriteViewController" {
            if let favoriteView = segue.destination as? FavoriteViewController {
                favoriteView.presenter = self.presenter?.router?.toFavoriteView()
            }
        } else if segue.identifier == "accountViewController" {
            if let accountView = segue.destination as? AccountViewController {
                //accountView.accountPresenter = self.presenter?.router?.toAccountView()
            }
        }
    }
    
    private func showUI() {
        tbGames.dataSource = self
        tbGames.delegate = self
        tbGames.register(UINib(nibName: "GamesTableViewCell", bundle: nil), forCellReuseIdentifier: "gamesTableViewCell")
        
        labelEmptyState.font = UIFont.preferredFont(forTextStyle: .title2).bold()
    }
    
    private func getListTeams() {
        showViewLoading(viewLoading, true)
        
        presenter?.getListGames(
            receiveCompletion: { completion in
                switch completion {
                case .finished:
                    showViewLoading(self.viewLoading, false)
                case .failure:
                    self.showToast(String(describing: completion))
                }
            },
            receiveValue: { games in
                if games.isEmpty {
                    showViewEmptyState(self.viewEmptyState, false)
                } else {
                    self.listGames = games
                    self.tbGames.reloadData()
                }
            })
    }
}

extension ViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listGames.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let game: Game
        
        if let cell = tableView.dequeueReusableCell(withIdentifier: "gamesTableViewCell", for: indexPath) as? GamesTableViewCell {
            game = listGames[indexPath.row]
            
            cell.ivGame.sd_setImage(with: URL(string: game.backgroundImage), placeholderImage: UIImage(named: "brokenimage"))

            var listGenre = [String]()
            let genres = game.genres
            if genres.count > 2 {
                let genre = Array(genres[..<2])
                genre.forEach { listGenre.append($0) }
                cell.labelGenre.text = listGenre.joined(separator: ", ")
            } else {
                genres.forEach { cell.labelGenre.text = $0 }
            }

            cell.labelTitle.text = game.name

            var listPlatform = [String]()
            let platforms = game.platforms
            platforms.forEach { listPlatform.append($0) }
            cell.labelPlatform.text = listPlatform.joined(separator: ", ")

            cell.labelRatingBar.text = String(game.rating)

            cell.labelReleaseDate.text = outputReleaseDateString(date: game.released)
            
            return cell
        } else {
            return UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tbGames.deselectRow(at: indexPath, animated: true)
        presenter?.toDetail(view: self, detailId: String(listGames[indexPath.row].id))
    }
}
