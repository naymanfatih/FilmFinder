//
//  SplashViewController.swift
//  FilmFinder
//
//  Created by Fatih on 25.08.2023.
//

import Alamofire
import UIKit

protocol SplashDisplayLogic: AnyObject {
    func displaySplashText(viewModel: Splash.RemoteConfig.ViewModel)
    func displayDashboard()
    func displayAlert(viewModel: Splash.Alert.ViewModel)
}

final class SplashViewController: UIViewController {
    @IBOutlet var splashLabel: UILabel!

    var interactor: SplashBusinessLogic?
    var router: (SplashRoutingLogic & SplashDataPassing)?

    // MARK: Object lifecycle

    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        setup()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }

    // MARK: Setup

    private func setup() {
        let viewController = self
        let interactor = SplashInteractor()
        let presenter = SplashPresenter()
        let router = SplashRouter()
        viewController.interactor = interactor
        viewController.router = router
        interactor.presenter = presenter
        presenter.viewController = viewController
        router.viewController = viewController
        router.dataStore = interactor
    }

    override public var preferredStatusBarStyle: UIStatusBarStyle {
        .darkContent
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        interactor?.checkInternetConnection()
        interactor?.fetchRemoteConfigValues()
    }
}

extension SplashViewController: SplashDisplayLogic {
    func displaySplashText(viewModel: Splash.RemoteConfig.ViewModel) {
        splashLabel.text = viewModel.text
        animateLabelAppearance()
        interactor?.fetchDashboard()
    }

    func displayDashboard() {
        router?.routeToDashboard()
    }

    func displayAlert(viewModel: Splash.Alert.ViewModel) {
        showAlert(title: viewModel.title, message: viewModel.message)
    }

    private func animateLabelAppearance() {
        splashLabel.alpha = 0.0
        splashLabel.transform = CGAffineTransform(translationX: 0, y: -30)

        UIView.animate(withDuration: 0.5, delay: 0.0, options: [.curveEaseOut], animations: {
            self.splashLabel.alpha = 1.0
            self.splashLabel.transform = .identity
        }, completion: { [weak self] _ in
            guard let self else { return }
            interactor?.fetchDashboard()
        })
    }
}
