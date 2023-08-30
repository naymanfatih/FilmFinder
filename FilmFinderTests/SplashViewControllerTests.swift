//
//  SplashViewControllerTests.swift
//  FilmFinderTests
//
//  Created by Fatih on 24.08.2023.
//

import XCTest
@testable import FilmFinder

class SplashViewControllerTests: XCTestCase {
    var viewController: SplashViewController!
    var interactorSpy: SplashInteractorSpy!
    var routerSpy: SplashRouterSpy!

    override func setUp() {
        super.setUp()
        viewController = UIApplication.getViewController()

        interactorSpy = SplashInteractorSpy()
        routerSpy = SplashRouterSpy()

        viewController.interactor = interactorSpy
        viewController.router = routerSpy

        viewController.loadViewIfNeeded()
    }

    func testFetchRemoteConfigValuesOnLoad() {
        XCTAssertTrue(interactorSpy.isFetchRemoteConfigValuesCalled)
    }

    func testCheckInternetConnectionOnLoad() {
        XCTAssertTrue(interactorSpy.isCheckInternetConnectionCalled)
    }

    func testDisplaySplashText() {
        let viewModel = Splash.RemoteConfig.ViewModel(text: "Test Text")
        viewController.displaySplashText(viewModel: viewModel)
        XCTAssertEqual(viewController.splashLabel.text, "Test Text")
    }

    func testDisplayDashboardTriggersRouteToDashboard() {
        viewController.displayDashboard()
        XCTAssertTrue(routerSpy.isRouteToDashboardCalled)
    }
}

class SplashInteractorSpy: SplashBusinessLogic {
    var isFetchRemoteConfigValuesCalled = false
    var isCheckInternetConnectionCalled = false

    func checkInternetConnection() {
        isCheckInternetConnectionCalled = true
    }

    func fetchRemoteConfigValues() {
        isFetchRemoteConfigValuesCalled = true
    }

    func fetchDashboard() {
        // This can be left empty
    }
}

class SplashRouterSpy: SplashRoutingLogic, SplashDataPassing {
    var dataStore: SplashDataStore?
    var isRouteToDashboardCalled = false

    func routeToDashboard() {
        isRouteToDashboardCalled = true
    }
}
