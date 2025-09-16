//
//  FootballNetworkProtocol.swift
//  SportApp
//
//  Created by mohamed ezz on 16/09/2025.
//

import Foundation

protocol FootballNetworkProtocol {
    static func fetchFootballFromJSON(completionHandler : @escaping (FootballRequest?)->Void)
}

