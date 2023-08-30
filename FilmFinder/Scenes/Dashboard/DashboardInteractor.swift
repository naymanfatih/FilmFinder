//
//  DashboardInteractor.swift
//  FilmFinder
//
//  Created by Fatih on 28.08.2023.
//

import Foundation

protocol DashboardBusinessLogic: AnyObject {
    func fetchMovies(request: Dashboard.Search.Request)
}

protocol DashboardDataStore: AnyObject {
    var movies: [Dashboard.Search.Response] { get set }
}

final class DashboardInteractor: DashboardBusinessLogic, DashboardDataStore {
    var presenter: DashboardPresentationLogic?
    var worker: DashboardWorkingLogic = DashboardWorker()

    var movies: [Dashboard.Search.Response] = [.init(title: "", imdbId: "")]

    func fetchMovies(request: Dashboard.Search.Request) {
        worker.getMovies(request: request.searchText) { [weak self] result in
            guard let self else { return }
            switch result {
            case let .success(response):
                if !response.isEmpty {
                    movies = response.map { .init(title: $0.title ?? "", imdbId: $0.imdbID ?? "") }
                    presenter?.presentMovies(response: movies)
                } else {
                    presenter?.presentNoResult()
                }
            case let .failure(error):
                print(error.localizedDescription)
                presenter?.presentNoResult()
            }
        }
    }
}
