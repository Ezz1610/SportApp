//
//  TennisLeaguePresenter.swift
//  SportApp
//
//  Created by mohamed ezz on 18/09/2025.
//

import Foundation
class TennisLeaguePresenter {
    let vc: TennisLeagueProtocol
    
    init(vc: TennisLeagueProtocol) {
        self.vc = vc
    }

    func getDataFromModel() {
        NetworkService.fetchData(from: ApiUrls.basketball) { (result: Result<TenniesLeagueRequest, Error>) in
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
