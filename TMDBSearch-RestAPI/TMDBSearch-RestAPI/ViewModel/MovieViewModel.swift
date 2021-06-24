//
//  MoviesTableViewCellViewModel.swift
//  TMDBSearch-RestAPI
//
//  Created by Jervy Umandap on 6/24/21.
//

import Foundation

class MovieViewModel {
    
    private var popularMovies = [Movie]()
    
    func fetchPopularMoviesData(completion: @escaping() -> ()) {
        APICaller.shared.getPopularMovies(completion: { [weak self] result in
            
            switch result {
            case .success(let data):
                self?.popularMovies = data.movies
                completion()
            case .failure(let error):
                print("Error proccessing json: - \(error)")
            }
        })
    }
    
    func numberOfRowsInSection(section: Int) -> Int {
        if popularMovies.count != 0 {
            return popularMovies.count
        }
        return 0
    }
    
    func cellForRowAt(indexPath: IndexPath) -> Movie {
        return popularMovies[indexPath.row]
        
    }
    
    
}
