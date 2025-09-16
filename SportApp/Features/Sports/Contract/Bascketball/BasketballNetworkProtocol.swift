//
//  BasketballNetworkProtocol.swift
//  SportApp
//
//  Created by mohamed ezz on 16/09/2025.
//

import Foundation
protocol BasketballNetworkProtocol {
    static func fetchBasketballFromJSON(completionHandler : @escaping (BasketballRequest?)->Void)
}

