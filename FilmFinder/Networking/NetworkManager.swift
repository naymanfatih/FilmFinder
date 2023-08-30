//
//  NetworkManager.swift
//  FilmFinder
//
//  Created by Fatih on 29.08.2023.
//

import Alamofire
import Foundation

final class NetworkManager {
    let baseURL: String
    private let interceptor: LogInterceptor

    init(baseURL: String = APIConfig.baseAPIURL, interceptor: LogInterceptor = LogInterceptor()) {
        self.baseURL = baseURL
        self.interceptor = interceptor
    }

    func request<T: Decodable>(baseRequest: BaseRequest, completion: @escaping (Result<T, Error>) -> Void) {
        LoadingAnimation.shared.show()
        let fullURL = APIConfig.baseAPIURL + baseRequest.path

        AF.request(
            fullURL,
            method: baseRequest.method,
            parameters: baseRequest.parameters,
            headers: baseRequest.headers,
            interceptor: interceptor
        )
        .validate()
        .responseDecodable(of: T.self) { response in
            LoadingAnimation.shared.hide()
            self.interceptor.printResponse(response)
            switch response.result {
            case let .success(object):
                completion(.success(object))
            case let .failure(error):
                completion(.failure(error))
            }
        }
    }
}

extension NetworkManager {
    static let shared = NetworkManager()
}
