//
//  CricketRequest.swift
//  SportApp
//
//  Created by mohamed ezz on 16/09/2025.
//

import Foundation

struct CricketRequest : Decodable{
    var result : [Cricket]
    var success : Int

}
struct Cricket : Decodable{
    var league_key : String
    var league_name : String
    var league_year : String
}



