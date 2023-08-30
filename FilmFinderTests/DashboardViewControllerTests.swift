//
//  DashboardViewControllerTests.swift
//  FilmFinderTests
//
//  Created by Fatih on 31.08.2023.
//

import Foundation
import XCTest
@testable import FilmFinder

class DashboardViewControllerTests: XCTestCase {
    var viewController: DashboardViewController!
    var interactorSpy: DashboardInteractorSpy!
    var routerSpy: DashboardRouterSpy!

    override func setUp() {
        super.setUp()
        viewController = UIApplication.getViewController()
        XCTAssertNotNil(viewController)

        interactorSpy = DashboardInteractorSpy()
        routerSpy = DashboardRouterSpy()

        viewController.interactor = interactorSpy
        viewController.router = routerSpy

        viewController.loadViewIfNeeded()
    }

    func testDisplayMovies() {
        let movie = Dashboard.Search.ViewModel(title: "Test Movie")
        viewController.displayMovies(viewModel: [movie])

        XCTAssertEqual(viewController.movies.count, 1)
        XCTAssertEqual(viewController.tableView.isHidden, false)
        XCTAssertEqual(viewController.noResultView.isHidden, true)
    }

    func testDisplayNoResult() {
        viewController.displayNoResult()
        XCTAssertEqual(viewController.tableView.isHidden, true)
        XCTAssertEqual(viewController.noResultView.isHidden, false)
    }

    func testSearchBarFunctionality() {
        viewController.searchBarSearchButtonClicked(viewController.searchBar)
        XCTAssertEqual(interactorSpy.isFetchMoviesCalled, false)

        viewController.searchBar.text = "Test"
        viewController.searchBarSearchButtonClicked(viewController.searchBar)
        XCTAssertEqual(interactorSpy.isFetchMoviesCalled, true)
    }
}

class DashboardInteractorSpy: DashboardBusinessLogic {
    var isFetchMoviesCalled = false

    func fetchMovies(request: Dashboard.Search.Request) {
        isFetchMoviesCalled = true
    }
}

class DashboardRouterSpy: DashboardRoutingLogic, DashboardDataPassing {
    var isRouteToDetailCalled = false
    var dataStore: DashboardDataStore?

    func routeToDetail(index: Int) {
        isRouteToDetailCalled = true
    }
}
