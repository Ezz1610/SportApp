//
//  SprortsLeague.swift
//  SportApp
//
//  Created by mohamed ezz on 21/09/2025.
//

import Foundation
struct SprortsLeagueResponse : Decodable{
    var result : [League]
    var success : Int

}
struct League : Decodable{
    var league_key : Int
    var league_name : String
    var country_key : Int
    var country_name : String
    var league_surface : String?
let league_logo: String?

}
