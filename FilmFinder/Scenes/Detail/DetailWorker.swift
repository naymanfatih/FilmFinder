//
//  DetailWorker.swift
//  FilmFinder
//
//  Created by Fatih on 28.08.2023.
//

import Foundation

protocol DetailWorkingLogic: AnyObject {
    func getDetails(imdbId: String, completion: @escaping (Result<MovieDetailResponse, Error>) -> Void)
}

final class DetailWorker: DetailWorkingLogic {
    func getDetails(imdbId: String, completion: @escaping (Result<MovieDetailResponse, Error>) -> Void) {
        let detailRequest = BaseRequest(path: "", method: .get, parameters: ["i": imdbId, "apikey": APIConfig.apiKey])

        NetworkManager.shared.request(baseRequest: detailRequest) { (result: Result<MovieDetailResponse, Error>) in
            switch result {
            case let .success(movieDetail):
                completion(.success(movieDetail))
            case let .failure(error):
                completion(.failure(error))
            }
        }
    }
}
