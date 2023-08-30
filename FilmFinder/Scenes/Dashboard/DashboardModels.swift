//
//  DashboardModels.swift
//  FilmFinder
//
//  Created by Fatih on 28.08.2023.
//

import Foundation

// swiftlint:disable nesting
enum Dashboard {
    enum Search {
        struct Request {
            let searchText: String
        }

        struct Response {
            let title: String
            let imdbId: String
        }

        struct ViewModel {
            let title: String
        }
    }
}

// swiftlint:enable nesting
