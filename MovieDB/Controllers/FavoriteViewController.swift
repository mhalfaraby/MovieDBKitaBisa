//
//  FavoriteViewController.swift
//  MovieDB
//
//  Created by MUHAMMAD ALFARABY on 10/03/21.
//

import UIKit
import Alamofire
import AlamofireImage

class FavoriteViewController: UIViewController {
    let defaults = UserDefaults.standard
    
    var favoriteArray: [Any] = []
    var favorites: [Detail] = []
    
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.separatorStyle = UITableViewCell.SeparatorStyle.none

        if let favorite = defaults.array(forKey: "favorite") {
            favoriteArray.append(contentsOf: favorite)
        }
        fetchDetail()
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
    }
    override func viewWillAppear(_ animated: Bool) {
        if let index = self.tableView.indexPathForSelectedRow{
            self.tableView.deselectRow(at: index, animated: true)
        }
    }
    func fetchDetail() {
        for id in favoriteArray {
            let apiKey = "0bc0b44455920f6f519ea6cf9094f2c4"
            let request =     AF.request("https://api.themoviedb.org/3/movie/\(id)?api_key=\(apiKey)&language=en-US").validate(statusCode: 200...500)
            request.responseDecodable(of: Detail.self) { (response) in
                guard let result = response.value else { return }
                self.favorites.append(result)
                
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            }
        }
    }
  
}

extension FavoriteViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return favorites.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! FavoriteCell
        cell.selectionStyle = .none
        let favorite = favorites[indexPath.row]
        let image = favorite.backdrop_path
        cell.favoriteTitleLabel.text = favorite.title
        cell.favoriteReleaseDateLabel.text = favorite.release_date
        cell.favoriteOverviewLabel.text = favorite.overview
        if let image = image {
            let url = "https://image.tmdb.org/t/p/w500//\(image)"
            
            let urlToImage = NSURL.init(string: url)
            
            cell.favoriteImageView.af.setImage(withURL: urlToImage! as URL)
            
        } else {
            cell.favoriteImageView.image = UIImage(named: "nophoto")
        }
        return cell
    }
}



