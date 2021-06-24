//
//  MovieViewController.swift
//  TMDBSearch-RestAPI
//
//  Created by Jervy Umandap on 6/24/21.
//

import UIKit

class MovieViewController: UIViewController {
    
    
    @IBOutlet weak var tableView: UITableView!
    
    private var viewModel = MovieViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        APICaller.shared.getPopularMovies(completion: { result in
            print(result)
        })
        loadPopularMovies()
    }
    
    private func loadPopularMovies() {
        viewModel.fetchPopularMoviesData { [weak self] in 
            self?.tableView.dataSource = self
            self?.tableView.reloadData()
//            self?.tableView.delegate = self
            
        }
    }


}

extension MovieViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRowsInSection(section: section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! MovieTableViewCell
        
        let movie = viewModel.cellForRowAt(indexPath: indexPath)
        
        cell.setCellWithValuesOf(movie)
        return cell
    }
    
}

