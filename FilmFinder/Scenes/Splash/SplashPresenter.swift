//
//  SplashPresenter.swift
//  FilmFinder
//
//  Created by Fatih on 25.08.2023.
//

import Foundation

protocol SplashPresentationLogic: AnyObject {
    func presentAlert(response: Splash.Alert.Response)
    func presentSplashText(response: Splash.RemoteConfig.Response)
    func presentDashboard()
}

final class SplashPresenter: SplashPresentationLogic {
    weak var viewController: SplashDisplayLogic?

    func presentAlert(response: Splash.Alert.Response) {
        viewController?.displayAlert(viewModel: .init(title: response.title, message: response.message))
    }

    func presentSplashText(response: Splash.RemoteConfig.Response) {
        viewController?.displaySplashText(viewModel: .init(text: response.text))
    }

    func presentDashboard() {
        viewController?.displayDashboard()
    }
}
