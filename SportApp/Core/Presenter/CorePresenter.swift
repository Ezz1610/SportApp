//
//  LeaguePresenter.swift
//  SportApp
//
//  Created by mohamed ezz on 18/09/2025.
//

import Foundation

class CorePresenter<ViewProtocol, ResponseType: Decodable> {
    let vc: ViewProtocol
    let apiUrl: String
    let queryItems: [URLQueryItem]
    let render: (ViewProtocol, ResponseType) -> Void
    
    init(
        vc: ViewProtocol,
        apiUrl: String,
        queryItems: [URLQueryItem] = [],
        render: @escaping (ViewProtocol, ResponseType) -> Void
    ) {
        self.vc = vc
        self.apiUrl = apiUrl
        self.queryItems = queryItems
        self.render = render
    }

    func getDataFromModel() {
        NetworkService.fetchData(from: apiUrl, queryItems: queryItems) { (result: Result<ResponseType, Error>) in
            DispatchQueue.main.async {
                switch result {
                case .success(let response):
                    self.render(self.vc, response)
                case .failure(let error):
                    print("Error fetching data: \(error.localizedDescription)")
                }
            }
        }
    }
}
