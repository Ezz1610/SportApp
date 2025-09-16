//
//  CricketPresenter.swift
//  SportApp
//
//  Created by mohamed ezz on 16/09/2025.
//

import Foundation
class CricketPresenter {
    let vc : CricketProtocol
    init(vc: CricketProtocol) {
        self.vc = vc
    }

    func getDataFromModel(){
        NetworkService.fetchCricketFromJSON{ res in
                    self.vc.renderToView(res: res!)

        }
    }
}
