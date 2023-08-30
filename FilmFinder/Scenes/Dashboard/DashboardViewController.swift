//
//  DashboardViewController.swift
//  FilmFinder
//
//  Created by Fatih on 28.08.2023.
//

import UIKit

protocol DashboardDisplayLogic: AnyObject {
    func displayMovies(viewModel: [Dashboard.Search.ViewModel])
    func displayNoResult()
}

final class DashboardViewController: UIViewController {
    @IBOutlet var searchBar: UISearchBar!
    @IBOutlet var tableView: UITableView!
    @IBOutlet var noResultView: UIView!

    var interactor: DashboardBusinessLogic?
    var router: (DashboardRoutingLogic & DashboardDataPassing)?

    var movies: [Dashboard.Search.ViewModel] = []

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
        let interactor = DashboardInteractor()
        let presenter = DashboardPresenter()
        let router = DashboardRouter()
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
        title = "Film Finder"
        navigationController?.navigationBar.prefersLargeTitles = true

        guard let searchBar = searchBar.value(forKey: "searchField") as? UITextField else { return }
        searchBar.backgroundColor = .blueLight.withAlphaComponent(0.5)
        searchBar.textColor = .blueDark
    }
}

extension DashboardViewController: DashboardDisplayLogic {
    func displayMovies(viewModel: [Dashboard.Search.ViewModel]) {
        movies = viewModel

        tableView.reloadData()
        animateTableView()

        tableView.isHidden = false
        noResultView.isHidden = true
    }

    private func animateTableView() {
        let cells = tableView.visibleCells
        let tableViewHeight = tableView.bounds.size.height

        for cell in cells {
            cell.transform = CGAffineTransform(translationX: 0, y: tableViewHeight)
        }

        var delayCounter = 0
        for cell in cells {
            UIView.animate(
                withDuration: 1.75,
                delay: Double(delayCounter) * 0.05,
                usingSpringWithDamping: 0.8,
                initialSpringVelocity: 0,
                options: .curveEaseInOut,
                animations: {
                    cell.transform = .identity
                },
                completion: nil
            )
            delayCounter += 1
        }
    }

    func displayNoResult() {
        tableView.isHidden = true
        noResultView.isHidden = false
    }
}

extension DashboardViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        movies.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "MovieCell", for: indexPath) as? MovieCell else {
            return UITableViewCell()
        }
        cell.configure(viewModel: movies[indexPath.row])
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        router?.routeToDetail(index: indexPath.row)
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        80
    }
}

extension DashboardViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let searchText = searchBar.text, !searchText.isEmpty else {
            tableView.reloadData()
            return
        }
        interactor?.fetchMovies(request: .init(searchText: searchText))
        searchBar.resignFirstResponder()
    }
}
