//
//  CricketLeaguePresenter.swift
//  SportApp
//
//  Created by mohamed ezz on 18/09/2025.
//

import Foundation
class CricketLeaguePresenter {
    let vc: CricketLeagueProtocol
    
    init(vc: CricketLeagueProtocol) {
        self.vc = vc
    }

    func getDataFromModel() {
        NetworkService.fetchData(from: ApiUrls.leaguesCricket) { (result: Result<CricketLeagueRequest, Error>) in
            DispatchQueue.main.async {
                switch result {
                case .success(let response):
                    self.vc.renderToView(res: response)
                case .failure(let error):
                    print("Error fetching Cricket data: \(error.localizedDescription)")
                }
            }
        }
    }
}
