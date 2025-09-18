//
//  ApiUrls.swift
//  SportApp
//
//  Created by mohamed ezz on 17/09/2025.
//

import Foundation
var apiKey : String = "2120f2f312d80b0c590180019e76e23dd650d20e9d0df7f0e778e0d0e6afc9bd"
import Foundation
class ApiUrls{
    static let baseUrl = "https://apiv2.allsportsapi.com"
    static let football  = "\(baseUrl)/football/?met=Countries&APIkey=\(apiKey)"
    static let basketball  = "\(baseUrl)/basketball/?met=Countries&APIkey=\(apiKey)"
    static let cricket  = "\(baseUrl)/cricket/?met=Countries&APIkey=\(apiKey)"
    static let tennis  = "\(baseUrl)/tennis/?met=Countries&APIkey=\(apiKey)"
    static let leaguesBasketball  = "\(baseUrl)/basketball/?met=Leagues&APIkey=\(apiKey)"
    static let leaguesFootball  = "\(baseUrl)/football/?met=Leagues&APIkey=\(apiKey)"
    static let leaguesTennis  = "\(baseUrl)/tennis/?met=Leagues&APIkey=\(apiKey)"
    static let leaguesCricket  = "\(baseUrl)/cricket/?met=Leagues&APIkey=\(apiKey)"

}
