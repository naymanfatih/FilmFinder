//
//  SplashRouter.swift
//  FilmFinder
//
//  Created by Fatih on 25.08.2023.
//

import Foundation
import UIKit

protocol SplashRoutingLogic: AnyObject {
    func routeToDashboard()
}

protocol SplashDataPassing: AnyObject {
    var dataStore: SplashDataStore? { get }
}

final class SplashRouter: SplashRoutingLogic, SplashDataPassing {
    weak var viewController: SplashViewController?
    var dataStore: SplashDataStore?

    func routeToDashboard() {
        let controller: DashboardViewController = UIApplication.getViewController()
        controller.modalPresentationStyle = .fullScreen
        viewController?.present(controller, animated: true)
    }
}
