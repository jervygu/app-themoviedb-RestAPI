//
//  APICaller.swift
//  TMDBSearch-RestAPI
//
//  Created by Jervy Umandap on 6/24/21.
//

import Foundation

class APICaller {
    
    static let shared = APICaller()
    
    let apiKey = "4dcc0cb5bbad7fb3209bd65aca372efe"
    
    enum APIError: Error {
        case failedToGetData
    }
    
    func getPopularMovies(completion: @escaping(Result<APIResponse, Error>) -> Void){
        let popularMoviesURL = "https://api.themoviedb.org/3/movie/popular?api_key=\(apiKey)&language=en-PH&page=1"
        
        guard let url = URL(string: popularMoviesURL) else {
            return
        }
        
        // create url session - work on background
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let data = data, error == nil else {
                completion(.failure(APIError.failedToGetData))
                return
            }
            do {
                let result = try JSONDecoder().decode(APIResponse.self, from: data)
                DispatchQueue.main.async {
                    completion(.success(result))
                }
            } catch {
                print("UserProfile: \(error.localizedDescription)")
                completion(.failure(error))
            }
            
        }
        task.resume()
        
    }
    
    
}
