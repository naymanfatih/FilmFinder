//
//  DetailPresenter.swift
//  FilmFinder
//
//  Created by Fatih on 28.08.2023.
//

import Foundation
import UIKit

protocol DetailPresentationLogic: AnyObject {
    func presentMovieDetail(response: Detail.Movie.Response)
    func presentAlert(response: Detail.Alert.Response)
}

final class DetailPresenter: DetailPresentationLogic {
    weak var viewController: DetailDisplayLogic?

    func presentMovieDetail(response: Detail.Movie.Response) {
        let viewModel = Detail.Movie.ViewModel(
            title: setBoldTitle(boldText: "Title: ", regularText: response.title, fontSize: 16),
            year: setBoldTitle(boldText: "Year: ", regularText: response.year, fontSize: 16),
            director: setBoldTitle(boldText: "Director: ", regularText: response.director, fontSize: 16),
            actors: setBoldTitle(boldText: "Actors: ", regularText: response.actors, fontSize: 16),
            poster: response.poster,
            imdbRating: setBoldTitle(boldText: "IMDB Rating: ", regularText: response.imdbRating, fontSize: 16)
        )
        viewController?.displayMovieDetail(viewModel: viewModel)
    }

    private func setBoldTitle(boldText: String, regularText: String, fontSize: CGFloat) -> NSAttributedString {
        let boldFont = UIFont.getFont(family: .heavy)
        let regularFont = UIFont.getFont(family: .medium)

        let boldString = NSMutableAttributedString(
            string: boldText,
            attributes: [
                NSAttributedString.Key.font: boldFont,
                NSAttributedString.Key.foregroundColor: UIColor.blueDark
            ]
        )
        let regularString = NSAttributedString(
            string: regularText,
            attributes: [
                NSAttributedString.Key.font: regularFont,
                NSAttributedString.Key.foregroundColor: UIColor.blueLight
            ]
        )

        boldString.append(regularString)

        return boldString
    }

    func presentAlert(response: Detail.Alert.Response) {
        viewController?.displayAlert(viewModel: .init(title: response.title, message: response.message))
    }
}
