//
//  SearchResponse.swift
//  FilmFinder
//
//  Created by Fatih on 29.08.2023.
//

import Foundation

public struct SearchResponse: Decodable {
    let search: [MovieResponse]?
    let totalResults: String?
    let response: String?
    let error: String?

    enum CodingKeys: String, CodingKey {
        case search = "Search"
        case totalResults
        case response = "Response"
        case error = "Error"
    }
}
