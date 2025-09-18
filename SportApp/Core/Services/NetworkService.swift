//
//  File.swift
//  ProductsApp
//
//  Created by mohamed ezz on 15/09/2025.
//

import Foundation


class NetworkService: FetchDataProtocol {
    
    static func fetchData<T: Decodable>(from url: String, completionHandler: @escaping (Result<T, Error>) -> Void) {
        guard let url = URL(string: url) else {
            completionHandler(.failure(NSError(domain: "InvalidURL", code: 400, userInfo: nil)))
            return
        }

        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data, response, error in
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
                print(decodedData)
            } catch {
                completionHandler(.failure(error))
            }
        }
        task.resume()
    }
}


