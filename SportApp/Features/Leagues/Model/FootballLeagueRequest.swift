//
//  foot.swift
//  SportApp
//
//  Created by mohamed ezz on 17/09/2025.
//

import Foundation

struct FootballLeagueRequest : Decodable{
    var result : [FootballLeague]
    var success : Int

}
struct FootballLeague : Decodable{
    var league_key : Int
    var league_name : String
    var country_key : Int
    var country_name : String
    var league_logo : String?
}
