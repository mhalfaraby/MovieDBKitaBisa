//
//  ViewController.swift
//  MovieDB
//
//  Created by MUHAMMAD ALFARABY on 09/03/21.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
    
    @IBAction func categoryPressed(_ sender: Any) {
        let optionMenu = UIAlertController(title: nil, message: "Choose Category", preferredStyle: .actionSheet)
        
        
        let popular = UIAlertAction(title: "Popular", style: .default) { _ in self.title = "Popular" }
        let upcoming = UIAlertAction(title: "Upcoming", style: .default)  { _ in self.title = "Upcoming" }
        let topRated = UIAlertAction(title: "Top Rated", style: .default)  { _ in self.title = "Top Rated" }
        let nowPlaying = UIAlertAction(title: "Now Playing", style: .default)  { _ in self.title = "Now Playing" }

        
        optionMenu.addAction(popular)
        optionMenu.addAction(upcoming)
        optionMenu.addAction(topRated)
        optionMenu.addAction(nowPlaying)

        self.present(optionMenu, animated: true, completion: nil)
        
    }
    
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 50
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! MovieCell
        
        return cell
        
    }
    
    
}

