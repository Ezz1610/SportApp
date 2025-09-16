//
//  TeniesRequest.swift
//  SportApp
//
//  Created by mohamed ezz on 16/09/2025.
//

import Foundation
struct TenniesRequest : Decodable{
    var result : [Tennies]
    var success : Int

}
struct Tennies : Decodable{
    var league_key : Int
    var league_name : String
    var country_key : Int
    var country_name : String
    var league_surface : String
}

