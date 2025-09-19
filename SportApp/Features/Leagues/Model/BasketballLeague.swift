//
//  BasketballLeague.swift
//  SportApp
//
//  Created by mohamed ezz on 17/09/2025.
//

import Foundation

struct BasketballLeagueRequest : Decodable{
    var result : [BasketballLeague]
    var success : Int
}

struct BasketballLeague : Decodable{
    var league_key : Int
    var country_key : Int
    var league_name : String
    var country_name : String
}



