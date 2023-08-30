//
//  Colors.swift
//  FilmFinder
//
//  Created by Fatih on 30.08.2023.
//

import Foundation
import UIKit

public extension UIColor {
    static var blueLight: UIColor { UIColor(colorName: "blueLight") }
    static var blueDark: UIColor { UIColor(colorName: "blueDark") }
}

public extension UIColor {
    convenience init(colorName: String) {
        self.init(named: colorName, in: .main, compatibleWith: .current)!
    }
}
