//
//  DashboardPresenter.swift
//  FilmFinder
//
//  Created by Fatih on 28.08.2023.
//

import Foundation

protocol DashboardPresentationLogic: AnyObject {
    func presentMovies(response: [Dashboard.Search.Response])
    func presentNoResult()
}

final class DashboardPresenter: DashboardPresentationLogic {
    weak var viewController: DashboardDisplayLogic?

    func presentMovies(response: [Dashboard.Search.Response]) {
        let viewModel: [Dashboard.Search.ViewModel] = response.map { .init(title: $0.title) }
        viewController?.displayMovies(viewModel: viewModel)
    }

    func presentNoResult() {
        viewController?.displayNoResult()
    }
}
