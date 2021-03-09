//
//  ViewController.swift
//  MovieDB
//
//  Created by MUHAMMAD ALFARABY on 09/03/21.
//

import UIKit
import Alamofire
import AlamofireImage

class ViewController: UIViewController {
    
    var movies: [Movies] = []
    
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        fetchPopular()
    }
//
    func fetchPopular() {


      let apiKey = "0bc0b44455920f6f519ea6cf9094f2c4"
      let request =  AF.request("https://api.themoviedb.org/3/movie/popular?api_key=\(apiKey)&language=en-US&page=1&region=US").validate(statusCode: 200...500)
      request.responseDecodable(of: MovieModel.self) { (response) in
        guard let result = response.value else { return }
        self.movies = result.results
        print(self.movies)
        DispatchQueue.main.async {
            self.tableView.reloadData()

        }
      }
    }
    func fetchUpcoming() {
      let apiKey = "0bc0b44455920f6f519ea6cf9094f2c4"
      let request =     AF.request("https://api.themoviedb.org/3/movie/upcoming?api_key=\(apiKey)&language=en-US&page=1&region=US").validate(statusCode: 200...500)
      request.responseDecodable(of: MovieModel.self) { (response) in
        guard let result = response.value else { return }
        self.movies = result.results
        print(self.movies)
        DispatchQueue.main.async {
            self.tableView.reloadData()

        }
        
      }
    }
    func fetchTopRated() {
      
      
      let apiKey = "0bc0b44455920f6f519ea6cf9094f2c4"
      let request =  AF.request("https://api.themoviedb.org/3/movie/top_rated?api_key=\(apiKey)&language=en-US&page=1&region=US").validate(statusCode: 200...500)
      request.responseDecodable(of: MovieModel.self) { (response) in
        guard let result = response.value else { return }
        self.movies = result.results
        print(self.movies)
        DispatchQueue.main.async {
            self.tableView.reloadData()

        }
    }
    }
    func fetchNowPlaying() {
      let apiKey = "0bc0b44455920f6f519ea6cf9094f2c4"
      let request =     AF.request("https://api.themoviedb.org/3/movie/now_playing?api_key=\(apiKey)&language=en-US&page=1&region=US").validate(statusCode: 200...500)
      request.responseDecodable(of: MovieModel.self) { (response) in
        guard let result = response.value else { return }
        self.movies = result.results
        print(self.movies)
        DispatchQueue.main.async {
            self.tableView.reloadData()

        }
        
      }
    }
    
    
    
    @IBAction func categoryPressed(_ sender: Any) {
        let optionMenu = UIAlertController(title: nil, message: "Choose Category", preferredStyle: .actionSheet)
        
        
        let popular = UIAlertAction(title: "Popular", style: .default) { _ in
            self.title = "Popular"
            self.fetchPopular()

        }
        let upcoming = UIAlertAction(title: "Upcoming", style: .default)  { _ in
            self.title = "Upcoming"
            self.fetchUpcoming()
            
        }
        let topRated = UIAlertAction(title: "Top Rated", style: .default)  { _ in
            self.title = "Top Rated"
            self.fetchTopRated()
        }
        let nowPlaying = UIAlertAction(title: "Now Playing", style: .default)  { _ in
            self.title = "Now Playing"
            self.fetchNowPlaying()
        }

        
        optionMenu.addAction(popular)
        optionMenu.addAction(upcoming)
        optionMenu.addAction(topRated)
        optionMenu.addAction(nowPlaying)

        self.present(optionMenu, animated: true, completion: nil)
        
    }
    
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movies.count    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! MovieCell
        let movie = movies[indexPath.row]
        let image = movie.backdrop_path
        cell.movieTitleLabel.text = movie.title
        cell.releaseDateLabel.text = movie.release_date
        cell.overviewLabel.text = movie.overview

        
        
        if let image = image {
            let url = "https://image.tmdb.org/t/p/w500//\(image)"

            let urlToImage = NSURL.init(string: url)

            cell.movieImageView.af.setImage(withURL: urlToImage! as URL)

        } else {
            cell.movieImageView.image = UIImage(named: "nophoto")
        }
        return cell
        
    }
    
    
}

