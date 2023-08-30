//
//  MovieDetailResponse.swift
//  FilmFinder
//
//  Created by Fatih on 29.08.2023.
//

import Foundation

struct MovieDetailResponse: Decodable {
    let title: String
    let year: String
    let director: String
    let actors: String
    let poster: String
    let imdbRating: String

    enum CodingKeys: String, CodingKey {
        case title = "Title"
        case year = "Year"
        case director = "Director"
        case actors = "Actors"
        case poster = "Poster"
        case imdbRating
    }
}
