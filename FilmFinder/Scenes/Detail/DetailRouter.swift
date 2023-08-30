//
//  DetailRouter.swift
//  FilmFinder
//
//  Created by Fatih on 28.08.2023.
//

import Foundation

protocol DetailRoutingLogic: AnyObject {}

protocol DetailDataPassing: AnyObject {
    var dataStore: DetailDataStore? { get }
}

final class DetailRouter: DetailRoutingLogic, DetailDataPassing {
    weak var viewController: DetailViewController?
    var dataStore: DetailDataStore?
}
