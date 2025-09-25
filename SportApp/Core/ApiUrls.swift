//
//  ApiUrls.swift
//  SportApp
//
//  Created by mohamed ezz on 17/09/2025.
//

import Foundation

class ApiUrls {
    /// IF YOU ADD QUERY STANDINGS THIS ( football  basketball  tennis cricket ) WILL IMPLEMENT THAT
    static let football  = "\(AppConstants.baseUrl)/football/"
    static let basketball  = "\(AppConstants.baseUrl)/basketball/"
    static let tennis  = "\(AppConstants.baseUrl)/tennis/"
    static let cricket  = "\(AppConstants.baseUrl)/cricket/"

    static let leaguesFootball  = "\(football)?met=Leagues"
    static let leaguesBasketball  = "\(basketball)?met=Leagues"
    static let leaguesTennis  = "\(tennis)?met=Leagues"
    static let leaguesCricket  = "\(cricket)?met=Leagues"
    
    static let footballFixtures  = "\(football)?met=Fixtures"
    static let basketballFixtures  = "\(basketball)?met=Fixtures"
    static let tennisFixtures  = "\(tennis)?met=Fixtures"
    static let cricketFixtures  = "\(cricket)?met=Fixtures"

}

/*
 {"error":"1","result":[{"param":null,"msg":"The difference between to and from cannot be greater than 15 days if there is no other parameter","cod":202}]}
 */
