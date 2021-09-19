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
    @IBOutlet weak var viewEmptyState: UIView!
    @IBOutlet weak var labelEmptyState: UILabel!
    
    private var listGames: [ResultsGames] = []
    private var service: ApiService?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.backButtonTitle = "Back"
        
        showUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getListTeams()
    }
    
    private func showUI() {
        tbGames.dataSource = self
        tbGames.delegate = self
        tbGames.register(UINib(nibName: "GamesTableViewCell", bundle: nil), forCellReuseIdentifier: "gamesTableViewCell")
        
        labelEmptyState.font = UIFont.preferredFont(forTextStyle: .title2).bold()
    }
    
    private func getListTeams() {
        service = ApiService()
        service?.getListGames { result in
            DispatchQueue.main.async {
                showViewLoading(self.viewLoading, true)
                
                if result.isEmpty {
                    showViewLoading(self.viewLoading, false)
                    showViewEmptyState(self.viewEmptyState, false)
                } else {
                    showViewLoading(self.viewLoading, false)
                    self.listGames = result
                    self.tbGames.reloadData()
                }
            }
        }
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
