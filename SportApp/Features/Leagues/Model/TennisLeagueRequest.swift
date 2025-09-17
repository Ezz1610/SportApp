//
//  TennisLeagueRequest.swift
//  SportApp
//
//  Created by mohamed ezz on 17/09/2025.
//

import Foundation
struct TenniesLeagueRequest : Decodable{
    var result : [TenniesLeague]
    var success : Int

}
struct TenniesLeague : Decodable{
    var league_key : Int
    var league_name : String
    var country_key : Int
    var country_name : String
    var league_surface : String
}



