//
//  FootballLeaguePresenter.swift
//  SportApp
//
//  Created by mohamed ezz on 18/09/2025.
//

import Foundation


class FootballLeaguePresenter {
    let vc: FootballLeagueProtocol
    
    init(vc: FootballLeagueProtocol) {
        self.vc = vc
    }

    func getDataFromModel() {
        NetworkService.fetchData(from: ApiUrls.leaguesFootball) { (result: Result<FootballLeagueRequest, Error>) in
            DispatchQueue.main.async {
                switch result {
                case .success(let response):
                    self.vc.renderToView(res: response)
                    print("✅ Football leagues count: \(response.result.count)")
                case .failure(let error):
                    print("Error fetching football data: \(error.localizedDescription)")
                }
            }
        }
    }
}
