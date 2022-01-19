//
//  ViewController.swift
//  gamescatalogue
//
//  Created by Alfa Centaury on 27/08/21.
//

import UIKit
import SDWebImage
import Games
import Common

class ViewController: UIViewController {
    
    @IBOutlet weak var tbGames: UITableView!
    @IBOutlet weak var viewLoading: UIView!
    @IBOutlet weak var viewEmptyState: UIView!
    @IBOutlet weak var labelEmptyState: UILabel!
    
    private var searchResultTableViewController: SearchResultTableViewController!
    private var searchController: UISearchController!
    private var listGames: [Game] = []
    private var currentPage = 1
    
    var presenter: HomePresenter?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.hidesSearchBarWhenScrolling = false
        self.navigationItem.backButtonTitle = "btn_back".localized()
        searchUI()
        showUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getListGames()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.navigationItem.hidesSearchBarWhenScrolling = true
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "favoriteViewController" {
            if let favoriteView = segue.destination as? FavoriteViewController {
                favoriteView.presenter = self.presenter?.router?.toFavoriteView()
            }
        } else if segue.identifier == "accountViewController" {
            if let accountView = segue.destination as? AccountViewController {
                accountView.accountPresenter = self.presenter?.router?.toAccountView()
            }
        }
    }
    
    private func showUI() {
        tbGames.dataSource = self
        tbGames.delegate = self
        tbGames.register(UINib(nibName: "GamesTableViewCell", bundle: nil), forCellReuseIdentifier: "gamesTableViewCell")
        
        labelEmptyState.font = UIFont.preferredFont(forTextStyle: .title2).bold()
        labelEmptyState.text = "text_no_games".localized()
    }
    
    private func searchUI() {
        searchResultTableViewController = storyboard?.instantiateViewController(
            withIdentifier: "SearchResultTableViewController") as? SearchResultTableViewController
        let presenter = SearchPresenter(router: SearchRouter())
        
        searchResultTableViewController.viewSearchController = self
        searchResultTableViewController.searchPresenter = presenter
        
        searchController = UISearchController(searchResultsController: searchResultTableViewController)
        
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationItem.largeTitleDisplayMode = .always
        self.navigationItem.searchController = searchController
        
        searchController.searchBar.placeholder = "Game"
        searchController.searchBar.delegate = self
        searchController.searchResultsUpdater = self
        
        definesPresentationContext = true
    }
    
    private func getListGames() {
        showViewLoading(viewLoading, true)
        
        presenter?.getListGames(
            page: String(currentPage),
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
                    self.listGames.append(contentsOf: games)
                    self.tbGames.reloadData()
                    
                    if self.currentPage > 1 {
                        let indexPathReload = self.calculateIndexPathsToReload(from: games)
                        self.tbGames.reloadRows(at: indexPathReload, with: .automatic)
                    }
                }
            })
        currentPage += 1
    }
    
    @objc private func searchFor(_ searchBar: UISearchBar) {
        guard searchController.isActive else { return }
        guard let searchText = searchBar.text, searchText.trimmingCharacters(in: .whitespaces) != "" else {
            searchResultTableViewController.resultSearch = nil
            return
        }

        getSearchGames(searchText)
    }
    
    private func getSearchGames(_ text: String) {
        presenter?.getSearchGames(
            text: text,
            receiveCompletion: { completion in
                switch completion {
                case .finished:
                    break
                case .failure:
                    self.showToast(String(describing: completion))
                }
            },
            receiveValue: { games in
                self.searchResultTableViewController.resultSearch = games.isEmpty ? nil : games
            })
    }
    
    private func calculateIndexPathsToReload(from newListGames: [Game]) -> [IndexPath] {
        let startIndex = listGames.count - newListGames.count
        let endIndex = startIndex + newListGames.count
        return (startIndex..<endIndex).map { IndexPath(row: $0, section: 0) }
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
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        let currentOffset = scrollView.contentOffset.y
        let maximumOffset = scrollView.contentSize.height - scrollView.frame.size.height
        
        if maximumOffset - currentOffset <= 10.0 {
            getListGames()
        }
    }
}

extension ViewController: UISearchBarDelegate, UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        if searchController.searchBar.searchTextField.isFirstResponder {
            searchController.showsSearchResultsController = true
            searchController.searchBar.searchTextField.backgroundColor = .white.withAlphaComponent(0.1)
        } else {
            searchController.searchBar.searchTextField.backgroundColor = nil
        }
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        NSObject.cancelPreviousPerformRequests(withTarget: self, selector: #selector(self.searchFor(_:)), object: searchBar)
        perform(#selector(self.searchFor(_:)), with: searchBar, afterDelay: 0.5)
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchResultTableViewController.resultSearch = nil
        searchController.searchBar.searchTextField.backgroundColor = nil
    }
}
