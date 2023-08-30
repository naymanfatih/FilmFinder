//
//  SplashInteractor.swift
//  FilmFinder
//
//  Created by Fatih on 25.08.2023.
//

import Alamofire
import Firebase
import Foundation
import UserNotifications

protocol SplashBusinessLogic: AnyObject {
    func checkInternetConnection()
    func fetchRemoteConfigValues()
    func fetchDashboard()
}

protocol SplashDataStore: AnyObject {}

final class SplashInteractor: SplashBusinessLogic, SplashDataStore {
    var presenter: SplashPresentationLogic?
    var worker: SplashWorkingLogic = SplashWorker()

    func checkInternetConnection() {
        let isConnectedToInternet = NetworkReachabilityManager()?.isReachable ?? false
        if !isConnectedToInternet {
            presenter?.presentAlert(response: .init(title: "Error", message: "Internet connection not found."))
        }
    }

    func fetchRemoteConfigValues() {
        let defaults: [String: NSObject] = ["splash_text": "" as NSObject]
        let remoteConfig = RemoteConfig.remoteConfig()
        remoteConfig.setDefaults(defaults)
        remoteConfig.fetch(withExpirationDuration: 0) { status, error in
            if status == .success {
                print("Config fetched!")
                remoteConfig.activate()
                let splashText = remoteConfig["splash_text"].stringValue ?? ""
                self.presenter?.presentSplashText(response: .init(text: splashText))
            } else {
                print("Config not fetched")
                self.presenter?.presentAlert(response: .init(
                    title: "Error",
                    message: error?.localizedDescription ?? ""
                ))
            }
        }
    }

    func fetchDashboard() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) { [weak self] in
            guard let self else { return }
            presenter?.presentDashboard()
        }
    }
}
