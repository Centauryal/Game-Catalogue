//
//  SearchResultTableViewController.swift
//  gamescatalogue
//
//  Created by Alfa Centaury on 17/01/22.
//

import UIKit
import SDWebImage
import Games
import Common

class SearchResultTableViewController: UITableViewController {

    @IBOutlet var tbSearchResult: UITableView!
    
    var searchPresenter: SearchPresenter?
    var viewSearchController: ViewController?
    
    var resultSearch: [Game]? {
        didSet {
            tbSearchResult.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        showUI()
    }
    
    private func showUI() {
        tbSearchResult.dataSource = self
        tbSearchResult.delegate = self
        tbSearchResult.register(UINib(nibName: "GamesTableViewCell", bundle: nil), forCellReuseIdentifier: "gamesTableViewCell")
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return resultSearch?.count ?? 0
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "gamesTableViewCell", for: indexPath) as? GamesTableViewCell {
            let search = resultSearch?[indexPath.row]
            
            cell.ivGame.sd_setImage(
                with: URL(string: search?.backgroundImage ?? "text_unknown".localized()),
                placeholderImage: UIImage(named: "brokenimage"))
            
            var listGenre = [String]()
            let genres = search?.genres
            if genres!.count > 2 {
                let genre = Array(genres![..<2])
                genre.forEach { listGenre.append($0) }
                cell.labelGenre.text = listGenre.joined(separator: ", ")
            } else {
                genres?.forEach { cell.labelGenre.text = $0 }
            }
            
            cell.labelTitle.text = search?.name
            
            var listPlatform = [String]()
            let platforms = search?.platforms
            platforms?.forEach { listPlatform.append($0) }
            cell.labelPlatform.text = listPlatform.joined(separator: ", ")
            
            cell.labelRatingBar.text = String(search!.rating)
            cell.labelReleaseDate.text = outputReleaseDateString(date: search?.released ?? "text_unknown".localized())
            
            return cell
        } else {
            return UITableViewCell()
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tbSearchResult.deselectRow(at: indexPath, animated: true)
        searchPresenter?.searchToDetail(
            view: self.viewSearchController!,
            detailId: String(resultSearch?[indexPath.row].id ?? 0))
    }
}
