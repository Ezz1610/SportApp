//
//  BasketballLeaguePresenter.swift
//  SportApp
//
//  Created by mohamed ezz on 18/09/2025.
//

import Foundation

class BasketballLeaguePresenter {
    let vc: BasketballLeagueProtocol
    
    init(vc: BasketballLeagueProtocol) {
        self.vc = vc
    }

    func getDataFromModel() {
        NetworkService.fetchData(from: ApiUrls.basketball) { (result: Result<BasketballLeagueRequest, Error>) in
            DispatchQueue.main.async {
                switch result {
                case .success(let response):
                    self.vc.renderToView(res: response)
                case .failure(let error):
                    print("Error fetching basketball data: \(error.localizedDescription)")
                }
            }
        }
    }
}
