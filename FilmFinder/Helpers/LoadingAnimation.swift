//
//  LoadingAnimation.swift
//  FilmFinder
//
//  Created by Fatih on 25.08.2023.
//

import Foundation
import Lottie
import UIKit

public final class LoadingAnimation: NSObject {
    public static let shared = LoadingAnimation()

    var loadingIndicator = LottieAnimationView(name: "loading_animation")
    var backgroundView = UIView()

    var isLoadingActive = false

    public func show(view: UIView? = UIApplication.shared.topWindow) {
        DispatchQueue.main.async { [weak self] in
            guard let self, let view, !isLoadingActive else { return }
            isLoadingActive = true
            backgroundView.frame = UIScreen.main.bounds
            backgroundView.backgroundColor = UIColor.gray.withAlphaComponent(0.5)

            loadingIndicator.frame = CGRect(origin: .zero, size: CGSize(width: 80, height: 80))
            loadingIndicator.center = backgroundView.center
            loadingIndicator.loopMode = .loop
            backgroundView.addSubview(loadingIndicator)

            view.addSubview(backgroundView)
            loadingIndicator.play()
        }
    }

    public func hide() {
        DispatchQueue.main.async { [weak self] in
            guard let self else { return }
            loadingIndicator.stop()
            backgroundView.removeFromSuperview()
            isLoadingActive = false
        }
    }
}

public extension UIApplication {
    var topWindow: UIWindow? {
        return connectedScenes
            .filter { $0.activationState == .foregroundActive }
            .compactMap { $0 as? UIWindowScene }
            .flatMap { $0.windows }
            .filter { $0.isKeyWindow }.first
    }
}
