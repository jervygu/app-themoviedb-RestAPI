//
//  MovieTableViewCell.swift
//  TMDBSearch-RestAPI
//
//  Created by Jervy Umandap on 6/24/21.
//

import UIKit

class MovieTableViewCell: UITableViewCell {
    
    @IBOutlet weak var moviePoster: UIImageView!
    @IBOutlet weak var movieTitle: UILabel!
    @IBOutlet weak var movieYear: UILabel!
    @IBOutlet weak var movieOverview: UILabel!
    @IBOutlet weak var movieRate: UILabel!
    
    private var urlString = ""
    
    let dateFormatter = DateFormatter()
    
    func setCellWithValuesOf(_ movie: Movie) {
        updateUI(title: movie.title,
                 releasedDate: movie.releaseDate,
                 overview: movie.overview,
                 rate: String(movie.voteAverage),
                 poster: movie.posterPath)
    }
    
    private func updateUI(title: String?, releasedDate: String?, overview: String?, rate: String?, poster: String?) {
        
        guard let title = title,
              let date = releasedDate,
              let overview = overview,
              let rating = rate,
              let posterString = poster else {
            return
        }
        
        movieTitle.text = title
        movieYear.text = date
        movieOverview.text = overview
        movieRate.text = rating
        
        
        urlString = "https://image.tmdb.org/t/p/w300" + posterString
        
        guard let posterImageUrl = URL(string: urlString) else {
            moviePoster.image = UIImage(named: "noImageAvailable")
            return
        }
        
        // before downloading image we clear out the old one
        moviePoster.image = nil
        getImageData(from: posterImageUrl)
    }
    
    
    
    private func getImageData(from url: URL) {
        let task = URLSession.shared.dataTask(with: url) { [weak self] (data, response, error) in
            
            guard let data = data, error == nil else {
                return
            }
            
            DispatchQueue.main.async {
                guard let image = UIImage(data: data) else {
                    return
                }
                self?.moviePoster.image = image
            }
                  
        }
        task.resume()
        
    }
    
//    override func prepareForReuse() {
//        moviePoster.image = nil
//        movieTitle.text = nil
//        movieYear.text = nil
//        movieOverview.text = nil
//        movieRate.text = nil
//    }

}
