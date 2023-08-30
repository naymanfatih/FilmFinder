//
//  LogInterceptor.swift
//  FilmFinder
//
//  Created by Fatih on 29.08.2023.
//

import Alamofire
import Foundation

final class LogInterceptor: RequestInterceptor {
    func adapt(
        _ urlRequest: URLRequest,
        for session: Session,
        completion: @escaping (Result<URLRequest, Error>) -> Void
    ) {
        printRequest(urlRequest)
        completion(.success(urlRequest))
    }

    func retry(
        _ request: Request,
        for session: Session,
        dueTo error: Error,
        completion: @escaping (RetryResult) -> Void
    ) {
        completion(.doNotRetry)
    }

    private func printRequest(_ request: URLRequest) {
        if let url = request.url?.absoluteString, let method = request.httpMethod {
            print("\n----- REQUEST -----\n")
            print("URL: \(url)")
            print("Method: \(method)")

            if let headers = request.allHTTPHeaderFields {
                print("Headers: \(headers)")
            }

            if let body = request.httpBody, let bodyString = String(data: body, encoding: .utf8) {
                print("Body: \(bodyString)")
            }
            print("\n----- END REQUEST -----\n")
        }
    }

    func printResponse<T>(_ response: DataResponse<T, AFError>) where T: Decodable {
        print("\n----- RESPONSE -----\n")
        if let data = response.data {
            do {
                if let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] {
                    let jsonData = try JSONSerialization.data(withJSONObject: json, options: .prettyPrinted)
                    if let jsonString = String(data: jsonData, encoding: .utf8) {
                        print("Data:\n\(jsonString)")
                    }
                }
            } catch {
                print("Error pretty printing json: \(error)")
            }
        }
        print("\nStatus Code: \(String(describing: response.response?.statusCode))\n")
        if let headers = response.response?.allHeaderFields as? [String: Any] {
            print("Headers:\n\(headers)")
        }
        print("\n----- END RESPONSE -----\n")
    }
}
