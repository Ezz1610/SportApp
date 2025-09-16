//
//  FootballPresenter.swift
//  SportApp
//
//  Created by mohamed ezz on 16/09/2025.
//

import Foundation
class FootballPresenter {
    let vc : FootballProtocol
    init(vc: FootballProtocol) {
        self.vc = vc
    }

    func getDataFromModel(){
        NetworkService.fetchFootballFromJSON{ res in
                    self.vc.renderToView(res: res!)

        }
    }
}
