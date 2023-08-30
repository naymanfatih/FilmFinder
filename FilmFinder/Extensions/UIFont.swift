//
//  UIFont.swift
//  FilmFinder
//
//  Created by Fatih on 30.08.2023.
//

import Foundation
import UIKit

public enum AvenirFontFamily: String {
    case medium = "Medium"
    case heavy = "Heavy"
}

extension UIFont {
    static func getFont(family: AvenirFontFamily, size: CGFloat = 16) -> UIFont {
        UIFont(name: "Avenir-\(family.rawValue)", size: size) ?? UIFont.systemFont(ofSize: size)
    }
}
