//
//  DashboardWorker.swift
//  FilmFinder
//
//  Created by Fatih on 28.08.2023.
//

import Alamofire
import Foundation

protocol DashboardWorkingLogic: AnyObject {
    func getMovies(request: String, completion: @escaping (Result<[MovieResponse], Error>) -> Void)
}

final class DashboardWorker: DashboardWorkingLogic {
    func getMovies(request: String, completion: @escaping (Result<[MovieResponse], Error>) -> Void) {
        let movieRequest = BaseRequest(path: "", method: .get, parameters: ["s": request, "apikey": APIConfig.apiKey])

        NetworkManager.shared.request(baseRequest: movieRequest) { (result: Result<SearchResponse, Error>) in
            switch result {
            case let .success(searchResult):
                completion(.success(searchResult.search ?? []))
            case let .failure(error):
                completion(.failure(error))
            }
        }
    }
}
