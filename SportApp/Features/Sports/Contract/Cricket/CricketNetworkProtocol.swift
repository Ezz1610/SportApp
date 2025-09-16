//
//  CricketNetworkProtocol.swift
//  SportApp
//
//  Created by mohamed ezz on 16/09/2025.
//

import Foundation
protocol CricketNetworkProtocol {
    static func fetchCricketFromJSON(completionHandler : @escaping (CricketRequest?)->Void)
}
