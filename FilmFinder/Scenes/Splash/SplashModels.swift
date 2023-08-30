//
//  SplashModels.swift
//  FilmFinder
//
//  Created by Fatih on 25.08.2023.
//

import Foundation

// swiftlint:disable nesting
enum Splash {
    enum RemoteConfig {
        struct Response {
            let text: String
        }

        struct ViewModel {
            let text: String
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
