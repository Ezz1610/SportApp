//
//  TennisNetworkProtocol.swift
//  SportApp
//
//  Created by mohamed ezz on 16/09/2025.
//

import Foundation
protocol TennisNetworkProtocol {
    static func fetchTenniesFromJSON(completionHandler : @escaping (TenniesRequest?)->Void)
}
