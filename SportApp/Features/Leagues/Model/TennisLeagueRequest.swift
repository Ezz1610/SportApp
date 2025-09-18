//
//  TennisLeagueRequest.swift
//  SportApp
//
//  Created by mohamed ezz on 17/09/2025.
//

import Foundation
struct TennisLeagueRequest: Codable {
    let success: Int
    let result: [TennisLeague]
}

struct TennisLeague: Codable {
    let league_key: Int
    let league_name: String
    let country_key: Int
    let country_name: String
    let league_logo: String?
    let country_logo: String?
    let league_surface: String?
}



