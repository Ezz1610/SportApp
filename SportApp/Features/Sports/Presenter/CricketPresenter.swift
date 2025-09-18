//
//  CricketPresenter.swift
//  SportApp
//
//  Created by mohamed ezz on 16/09/2025.
//


import Foundation

class CricketPresenter {
    let vc: CricketProtocol
    
    init(vc: CricketProtocol) {
        self.vc = vc
    }

    func getDataFromModel() {
        NetworkService.fetchData(from: ApiUrls.cricket) { (result: Result<CricketRequest, Error>) in
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
