//
//  MovieCell.swift
//  FilmFinder
//
//  Created by Fatih on 28.08.2023.
//

import Foundation
import UIKit

final class MovieCell: UITableViewCell {
    @IBOutlet var containerView: UIView!
    @IBOutlet var titleLabel: UILabel!

    func configure(viewModel: Dashboard.Search.ViewModel) {
        containerView.layer.cornerRadius = 25
        titleLabel.text = viewModel.title
    }
}
