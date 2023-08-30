//
//  MovieResponse.swift
//  FilmFinder
//
//  Created by Fatih on 29.08.2023.
//

import Foundation

public struct MovieResponse: Decodable {
    let title: String?
    let year: String?
    let imdbID: String?
    let movieType: String?
    let poster: String?

    enum CodingKeys: String, CodingKey {
        case title = "Title"
        case year = "Year"
        case imdbID
        case movieType = "Type"
        case poster = "Poster"
    }
}
