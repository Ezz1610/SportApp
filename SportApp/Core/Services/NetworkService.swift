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
        // Build the URL with query items
        var components = URLComponents(string: baseURL)
        components?.queryItems = queryItems
        
        guard let finalURL = components?.url else {
            completionHandler(.failure(NSError(domain: "InvalidURL", code: 400, userInfo: nil)))
            return
        }

        print("Request URL: \(finalURL.absoluteString)")

        // Create the request and start the task
        let task = URLSession.shared.dataTask(with: finalURL) { data, response, error in
            if let error = error {
                completionHandler(.failure(error))
                return
            }

            guard let data = data else {
                completionHandler(.failure(NSError(domain: "NoData", code: 204, userInfo: nil)))
                return
            }
//            do {
//                let decodedData = try JSONDecoder().decode(T.self, from: data)
//                completionHandler(.success(decodedData))
//            } catch {
//                // 🔍 Print raw response and decoding error
//                print("❌ Decoding error: \(error.localizedDescription)")
//                print("🔍 Raw response:")
//                print(String(data: data, encoding: .utf8) ?? "Invalid JSON")
//                completionHandler(.failure(error))
//            }

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



/*
func testFetchUpcomingFootballFixtures() {
    let exp = expectation(description: "Fetching upcoming football fixtures")

    let url = ApiUrls.footballFixtures
    let queryItems = [
        URLQueryItem(name: "APIkey", value: AppConstants.apiKey),
        URLQueryItem(name: "from", value: "2025-09-25"),
        URLQueryItem(name: "to", value: "2025-09-30"),
        URLQueryItem(name: "leagueId", value:"4")

    ]

    NetworkService.fetchData(from: url, queryItems: queryItems) { (result: Result<FixturesResponse, Error>) in
        switch result {
        case .success(let response):
            XCTAssertEqual(response.success, 1, "API should return success: 1")
            XCTAssertNotNil(response.result, "Result should not be nil")
            XCTAssertFalse(response.result.isEmpty, "Fixtures list should not be empty")

                    case .failure(let error):
            XCTFail("Error: \(error.localizedDescription)")
        }
        exp.fulfill()
    }

    waitForExpectations(timeout: 15)
}
*/
