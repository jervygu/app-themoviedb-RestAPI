//
//  Model.swift
//  TMDBSearch-RestAPI
//
//  Created by Jervy Umandap on 6/24/21.
//

import Foundation

// MARK: - APIResponse
struct APIResponse: Codable {
    let page: Int
    let movies: [Movie]
    let totalPages, totalResults: Int

    enum CodingKeys: String, CodingKey {
        case movies = "results"
        case page
        case totalPages = "total_pages"
        case totalResults = "total_results"
    }
}

// MARK: - Movie
struct Movie: Codable {
    let adult: Bool
    let id: Int
    let originalTitle, overview: String
    let popularity: Double
    let posterPath: String
    let releaseDate: String?
    let title: String
    let voteAverage: Double
    let voteCount: Int

    enum CodingKeys: String, CodingKey {
        case adult
        case id
        case originalTitle = "original_title"
        case overview, popularity
        case posterPath = "poster_path"
        case releaseDate = "release_date"
        case title
        case voteAverage = "vote_average"
        case voteCount = "vote_count"
    }
}
