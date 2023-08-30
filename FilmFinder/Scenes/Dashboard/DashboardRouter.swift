//
//  DashboardRouter.swift
//  FilmFinder
//
//  Created by Fatih on 28.08.2023.
//

import Foundation
import UIKit

protocol DashboardRoutingLogic: AnyObject {
    func routeToDetail(index: Int)
}

protocol DashboardDataPassing: AnyObject {
    var dataStore: DashboardDataStore? { get }
}

final class DashboardRouter: DashboardRoutingLogic, DashboardDataPassing {
    weak var viewController: DashboardViewController?
    var dataStore: DashboardDataStore?

    func routeToDetail(index: Int) {
        let controller: DetailViewController = UIApplication.getViewController()
        guard let selectedMovie = dataStore?.movies[index] else { return }
        controller.router?.dataStore?.movieId = selectedMovie.imdbId
        viewController?.presentAsSheet(controller: controller)
    }
}
