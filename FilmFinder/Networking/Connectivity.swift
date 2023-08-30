//
//  Connectivity.swift
//  FilmFinder
//
//  Created by Fatih on 25.08.2023.
//

import Alamofire
import Foundation

final class Connectivity {
    static var sharedInstance = NetworkReachabilityManager()
    static var isConnectedToInternet: Bool {
        return sharedInstance?.isReachable ?? false
    }
}
