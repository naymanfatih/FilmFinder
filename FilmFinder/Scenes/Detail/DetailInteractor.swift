//
//  DetailInteractor.swift
//  FilmFinder
//
//  Created by Fatih on 28.08.2023.
//

import Firebase
import FirebaseAnalytics
import Foundation

protocol DetailBusinessLogic: AnyObject {
    func fetchMovieDetail()
}

protocol DetailDataStore: AnyObject {
    var movieId: String { get set }
}

final class DetailInteractor: DetailBusinessLogic, DetailDataStore {
    var presenter: DetailPresentationLogic?
    var worker: DetailWorkingLogic = DetailWorker()

    var movieId: String = ""

    func fetchMovieDetail() {
        Analytics.logEvent("movie_detail", parameters: ["imdbId": movieId])

        worker.getDetails(imdbId: movieId) { [weak self] result in
            guard let self else { return }
            switch result {
            case let .success(response):
                let response: Detail.Movie.Response = .init(
                    title: response.title,
                    year: response.year,
                    director: response.director,
                    actors: response.actors,
                    poster: response.poster,
                    imdbRating: response.imdbRating
                )
                presenter?.presentMovieDetail(response: response)
            case let .failure(error):
                presenter?.presentAlert(response: .init(title: "Error", message: error.localizedDescription))
            }
        }
    }
}
