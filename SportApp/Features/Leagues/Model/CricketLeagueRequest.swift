//
//  CricketLeagueRequest.swift
//  SportApp
//
//  Created by mohamed ezz on 17/09/2025.
//

import Foundation

struct CricketLeagueRequest : Decodable{
    var result : [CricketLeague]
    var success : Int

}
struct CricketLeague : Decodable{
    var league_key : String
    var league_name : String
    var league_year : String
}

