//
//  DetailViewControllerTests.swift
//  FilmFinderTests
//
//  Created by Fatih on 31.08.2023.
//

import Foundation
import XCTest
@testable import FilmFinder

class DetailViewControllerTests: XCTestCase {
    var viewController: DetailViewController!
    var interactorSpy: DetailInteractorSpy!

    override func setUp() {
        super.setUp()
        viewController = UIApplication.getViewController()
        XCTAssertNotNil(viewController)

        interactorSpy = DetailInteractorSpy()
        viewController.interactor = interactorSpy

        viewController.loadViewIfNeeded()
    }

    func testDisplayMovieDetail() {
        let viewModel = Detail.Movie.ViewModel(
            title: "Test Movie",
            year: "2023",
            director: "Test Director",
            actors: "Test Actor",
            poster: "url",
            imdbRating: "9.9"
        )
        viewController.displayMovieDetail(viewModel: viewModel)

        XCTAssertEqual(viewController.titleLabel.text?.contains("Test Movie"), true)
        XCTAssertEqual(viewController.yearLabel.text?.contains("2023"), true)
        XCTAssertEqual(viewController.directorLabel.text?.contains("Test Director"), true)
    }
}

class DetailInteractorSpy: DetailBusinessLogic {
    var isFetchMovieDetailCalled = false

    func fetchMovieDetail() {
        isFetchMovieDetailCalled = true
    }
}
