//
//  BascketBall.swift
//  SportApp
//
//  Created by mohamed ezz on 16/09/2025.
//

import Foundation


struct BasketballRequest : Decodable{
    var result : [Basketball]
    var success : Int

}
struct Basketball : Decodable{
    var country_key : String
    var country_name : String
}

