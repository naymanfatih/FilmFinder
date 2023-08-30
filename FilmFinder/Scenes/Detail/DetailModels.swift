//
//  DetailModels.swift
//  FilmFinder
//
//  Created by Fatih on 28.08.2023.
//

import Foundation

// swiftlint:disable nesting
enum Detail {
    enum Movie {
        struct Request {}

        struct Response {
            let title: String
            let year: String
            let director: String
            let actors: String
            let poster: String
            let imdbRating: String
        }

        struct ViewModel {
            let title: NSAttributedString
            let year: NSAttributedString
            let director: NSAttributedString
            let actors: NSAttributedString
            let poster: String
            let imdbRating: NSAttributedString
        }
    }

    enum Alert {
        struct Response {
            let title: String
            let message: String
        }

        struct ViewModel {
            let title: String
            let message: String
        }
    }
}

// swiftlint:enable nesting
