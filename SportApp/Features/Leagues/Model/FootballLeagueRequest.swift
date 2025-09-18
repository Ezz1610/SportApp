//
//  foot.swift
//  SportApp
//
//  Created by mohamed ezz on 17/09/2025.
//

import Foundation

struct FootballLeagueRequest : Codable{
    var success : Int
    var result : [FootballLeague]
}
struct FootballLeague : Codable{
    var league_key : Int
    var league_name : String
    var country_key : Int
    var country_name : String
    let league_logo: String?
}

