//
//  File.swift
//  ProductsApp
//
//  Created by mohamed ezz on 15/09/2025.
//

import Foundation


class NetworkService: FetchDataProtocol {

    /// Generic fetch function that supports query parameters
    static func fetchData<T: Decodable>(
        from baseURL: String,
        queryItems: [URLQueryItem] = [],
        completionHandler: @escaping (Result<T, Error>) -> Void
    ) {
        var components = URLComponents(string: baseURL)
        components?.queryItems = queryItems
        
        guard let finalURL = components?.url else {
            completionHandler(.failure(NSError(domain: "InvalidURL", code: 400, userInfo: nil)))
            return
        }

        print("Request URL: \(finalURL.absoluteString)")

        let task = URLSession.shared.dataTask(with: finalURL) { data, response, error in
            if let error = error {
                completionHandler(.failure(error))
                return
            }

            guard let data = data else {
                completionHandler(.failure(NSError(domain: "NoData", code: 204, userInfo: nil)))
                return
            }

            do {
                let decodedData = try JSONDecoder().decode(T.self, from: data)
                completionHandler(.success(decodedData))
            } catch {
                completionHandler(.failure(error))
            }
        }

        task.resume()
    }
}



