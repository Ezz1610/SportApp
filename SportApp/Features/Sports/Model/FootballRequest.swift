//
//  ProductRequest.swift
//  ProductsApp
//
//  Created by mohamed ezz on 15/09/2025.
//

import Foundation

struct FootballRequest : Decodable{
    var result : [Football]
    var success : Int

}
struct Football : Decodable{
    var country_key : String
    var country_name : String
    var country_iso2 : String
    var country_logo : String
}


