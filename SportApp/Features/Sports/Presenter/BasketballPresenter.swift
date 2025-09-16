//
//  BasketballPresenter.swift
//  SportApp
//
//  Created by mohamed ezz on 16/09/2025.
//

import Foundation
class BasketballPresenter {
    let vc : BasketballProtocol
    init(vc: BasketballProtocol) {
        self.vc = vc
    }

    func getDataFromModel(){
        NetworkService.fetchBasketballFromJSON{ res in
                    self.vc.renderToView(res: res!)

        }
    }
}
