//
//  Recommandation.swift
//  SeSAC3Week5
//
//  Created by 정경우 on 2023/08/17.
//

// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let movieInfo = try? JSONDecoder().decode(MovieInfo.self, from: jsonData)

import Foundation

// MARK: - Recommandation
struct Recommandation: Codable {
    let page, totalResults, totalPages: Int
    let results: [Movie]

    enum CodingKeys: String, CodingKey {
        case page
        case totalResults = "total_results"
        case totalPages = "total_pages"
        case results
    }
}

// MARK: - Result
struct Movie: Codable {
    let id: Int
    let genreIDS: [Int]
    let originalTitle: String
    let originalLanguage: String
    let mediaType: MediaType
    let voteAverage: Double
    let backdropPath: String?
    let releaseDate: String
    let voteCount: Int
    let overview, title: String
    let posterPath: String?
    let video: Bool
    let popularity: Double
    let adult: Bool

    enum CodingKeys: String, CodingKey {
        case id
        case genreIDS = "genre_ids"
        case originalTitle = "original_title"
        case originalLanguage = "original_language"
        case mediaType = "media_type"
        case voteAverage = "vote_average"
        case backdropPath = "backdrop_path"
        case releaseDate = "release_date"
        case voteCount = "vote_count"
        case overview, title
        case posterPath = "poster_path"
        case video, popularity, adult
    }
}

enum MediaType: String, Codable {
    case movie = "movie"
}

//enum OriginalLanguage: String, Codable {
//    case en = "en"
//    case fr = "fr"
//    case ko = "ko"
//    case nl = "nl"
//}

