//
//  DetailMoviesViewController.swift
//  MovieDB
//
//  Created by MUHAMMAD ALFARABY on 10/03/21.
//

import UIKit
import AlamofireImage
class DetailViewController: UIViewController {
    
    let defaults = UserDefaults.standard
    var detailMovies: Movies?
    var isFavourited = false
    @IBOutlet weak var movieImageView: UIImageView!
    @IBOutlet weak var movieTitleLabel: UILabel!
    @IBOutlet weak var releaseDateLabel: UILabel!
    @IBOutlet weak var overviewLabel: UILabel!
    @IBOutlet weak var addToFavoriteButton: UIBarButtonItem!
    override func viewDidLoad() {
        
        addToFavoriteButton.setBackgroundImage(UIImage(systemName: "suit.heart"), for: .normal, barMetrics: .default)
        super.viewDidLoad()
        movieTitleLabel.text = detailMovies?.title
        releaseDateLabel.text = detailMovies?.release_date
        overviewLabel.text = detailMovies?.overview
        
        if let image = detailMovies?.poster_path {
            let url = "https://image.tmdb.org/t/p/w500//\(image)"
            
            let urlToImage = NSURL.init(string: url)
            movieImageView.af.setImage(withURL: urlToImage! as URL )
        }
        else {
            movieImageView.image = UIImage(named: "nophoto")
        }
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if detailMovies!.id == defaults.integer(forKey: "\(detailMovies!.id)") {
            addToFavoriteButton.setBackgroundImage(UIImage(systemName: "suit.heart.fill"), for: .normal, barMetrics: .default)
            isFavourited = true
        }
    }
    @IBAction func addToFavoriteButtonPressed(_ sender: UIBarButtonItem) {
        
        isFavourited = !isFavourited
        if isFavourited{
            defaults.setValue(detailMovies!.id, forKey: "\(detailMovies!.id)")
            var currentArray:[Int] = defaults.array(forKey: "favorite")as? [Int] ?? []
            currentArray.append(detailMovies!.id)
            defaults.set(currentArray, forKey: "favorite")
            addToFavoriteButton.setBackgroundImage(UIImage(systemName: "suit.heart.fill"), for: .normal, barMetrics: .default)
            addToFavoriteButton.tintColor = .red
        }
        else {
            addToFavoriteButton.setBackgroundImage(UIImage(systemName: "suit.heart"), for: .normal, barMetrics: .default)
            
            defaults.removeObject(forKey: "\(detailMovies!.id)")
            let currentArray:[Int] = defaults.array(forKey: "favorite")as? [Int] ?? []
            let removed = currentArray.filter{$0 != detailMovies!.id}
            
            defaults.removeObject(forKey: "favorite")
            defaults.set(removed, forKey: "favorite")
        }
    }
}
