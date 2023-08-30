//
//  DetailViewController.swift
//  FilmFinder
//
//  Created by Fatih on 28.08.2023.
//

import Lottie
import SDWebImage
import UIKit

protocol DetailDisplayLogic: AnyObject {
    func displayMovieDetail(viewModel: Detail.Movie.ViewModel)
    func displayAlert(viewModel: Detail.Alert.ViewModel)
}

final class DetailViewController: UIViewController {
    @IBOutlet var containerStackView: UIStackView!
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var yearLabel: UILabel!
    @IBOutlet var directorLabel: UILabel!
    @IBOutlet var actorsLabel: UILabel!
    @IBOutlet var imdbRatingLabel: UILabel!
    @IBOutlet var posterImageView: UIImageView!
    
    var interactor: DetailBusinessLogic?
    var router: (DetailRoutingLogic & DetailDataPassing)?
    
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
        let interactor = DetailInteractor()
        let presenter = DetailPresenter()
        let router = DetailRouter()
        viewController.interactor = interactor
        viewController.router = router
        interactor.presenter = presenter
        presenter.viewController = viewController
        router.viewController = viewController
        router.dataStore = interactor
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        interactor?.fetchMovieDetail()
        
        registerHandyStackView(containerStackView)
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(posterTapped))
        posterImageView.isUserInteractionEnabled = true
        posterImageView.addGestureRecognizer(tapGesture)
    }
    
    @objc private func posterTapped() {
        showFullScreenPoster()
    }
}

extension DetailViewController: DetailDisplayLogic {
    func displayMovieDetail(viewModel: Detail.Movie.ViewModel) {
        titleLabel.attributedText = viewModel.title
        yearLabel.attributedText = viewModel.year
        directorLabel.attributedText = viewModel.director
        actorsLabel.attributedText = viewModel.actors
        imdbRatingLabel.attributedText = viewModel.imdbRating
        posterImageView.sd_setImage(with: URL(string: viewModel.poster))
    }
    
    func displayAlert(viewModel: Detail.Alert.ViewModel) {
        showAlert(title: viewModel.title, message: viewModel.message)
    }
}

extension DetailViewController {
    private func showFullScreenPoster() {
        let fullScreenViewController = UIViewController()
        fullScreenViewController.modalPresentationStyle = .overFullScreen
        fullScreenViewController.view.backgroundColor = UIColor.clear
        
        let blurEffect = UIBlurEffect(style: .dark)
        let blurredEffectView = UIVisualEffectView(effect: blurEffect)
        blurredEffectView.frame = fullScreenViewController.view.bounds
        fullScreenViewController.view.addSubview(blurredEffectView)
        
        let closeButton = UIButton(type: .system)
        closeButton.setImage(UIImage(systemName: "xmark"), for: .normal)
        closeButton.frame = CGRect(x: fullScreenViewController.view.frame.width - 60, y: 40, width: 50, height: 50)
        closeButton.tintColor = .white
        closeButton.addTarget(self, action: #selector(dismissFullScreenPoster), for: .touchUpInside)
        fullScreenViewController.view.addSubview(closeButton)
        
        let margin: CGFloat = 20.0
        let fullScreenImageView = UIImageView(frame: CGRect(
            x: margin,
            y: 0,
            width: fullScreenViewController.view.frame.width - 2 * margin,
            height: fullScreenViewController.view.frame.height
        ))
        fullScreenImageView.contentMode = .scaleAspectFit
        fullScreenImageView.image = posterImageView.image
        fullScreenViewController.view.addSubview(fullScreenImageView)
        fullScreenViewController.view.bringSubviewToFront(closeButton)
        
        present(fullScreenViewController, animated: true, completion: nil)
    }
    
    @objc private func dismissFullScreenPoster() {
        dismiss(animated: true, completion: nil)
    }
}
