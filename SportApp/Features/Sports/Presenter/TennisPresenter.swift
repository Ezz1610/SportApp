//
//  TennisPresenter.swift
//  SportApp
//
//  Created by mohamed ezz on 16/09/2025.
//

import Foundation
class TennisPresenter {
    let vc : TennisProtocol
    init(vc: TennisProtocol) {
        self.vc = vc
    }

    func getDataFromModel(){
        NetworkService.fetchTenniesFromJSON{ res in
                    self.vc.renderToView(res: res!)

        }
    }
}
