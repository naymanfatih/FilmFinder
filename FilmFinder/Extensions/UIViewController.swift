//
//  UIViewController.swift
//  FilmFinder
//
//  Created by Fatih on 28.08.2023.
//

import Foundation
import HandyViewController
import UIKit

public extension UIViewController {
    func presentAsSheet(
        controller: UIViewController?,
        contentMode: ContentMode = .contentSize,
        syncViewHeightWithKeyboard: Bool = true,
        maxBackgroundOpacity: CGFloat = 0.5
    ) {
        guard let controller else { return }
        controller.modalPresentationStyle = .custom
        let delegate = HandyTransitioningDelegate(
            from: self,
            to: controller,
            contentMode: contentMode,
            syncViewHeightWithKeyboard: syncViewHeightWithKeyboard,
            maxBackgroundOpacity: maxBackgroundOpacity
        )
        controller.transitioningDelegate = delegate
        present(controller, animated: true, completion: nil)
    }

    func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        DispatchQueue.main.async { [weak self] in
            guard let self else { return }
            present(alert, animated: true, completion: nil)
        }
    }
}
