//
//  BaseRequest.swift
//  FilmFinder
//
//  Created by Fatih on 29.08.2023.
//

import Alamofire
import Foundation

struct BaseRequest {
    var path: String
    var method: HTTPMethod
    var parameters: Parameters?
    var headers: HTTPHeaders?

    init(path: String, method: HTTPMethod, parameters: Parameters? = nil, headers: HTTPHeaders? = nil) {
        self.path = path
        self.method = method
        self.parameters = parameters
        self.headers = headers
    }
}
