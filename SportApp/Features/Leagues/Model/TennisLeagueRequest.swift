//
//  TennisLeagueRequest.swift
//  SportApp
//
//  Created by mohamed ezz on 17/09/2025.
//

import Foundation
struct TennisLeagueRequest : Decodable{
    var result : [TennisLeague]
    var success : Int

}
struct TennisLeague : Decodable{
    var league_key : Int
    var league_name : String
    var country_key : Int
    var country_name : String
    var league_surface : String?
}



