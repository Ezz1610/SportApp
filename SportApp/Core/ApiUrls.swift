//
//  ApiUrls.swift
//  SportApp
//
//  Created by mohamed ezz on 17/09/2025.
//

import Foundation
var apiKey : String = "2120f2f312d80b0c590180019e76e23dd650d20e9d0df7f0e778e0d0e6afc9bd"

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
    
    ////// READ THIS COMMENT
    /// Delete old version of fixtures end points ( footballFixtures & basketballFixtures  & cricketFixtures & tennisFixtures)

    static let footballFixtures  = "\(baseUrl)/football/?met=Fixtures&APIkey=\(apiKey)&from=209-05-23&to=2019-05-23"
    static let basketballFixtures  = "\(baseUrl)/basketball/?met=Fixtures&APIkey=\(apiKey)&from=209-05-23&to=2019-05-23"
    static let cricketFixtures  = "\(baseUrl)/cricket/?met=Fixtures&APIkey=\(apiKey)&from=209-05-23&to=2019-05-23"
    static let tennisFixtures  = "\(baseUrl)/tennis/?met=Fixtures&APIkey=\(apiKey)&from=209-05-23&to=2019-05-23"
    
///FIXTURES UPCOMMING EVENTS

    static let upCommingEventsFootballFixtures  = "\(baseUrl)/football/?met=Fixtures&APIkey=\(apiKey)&from=\(AppConstants.getNowDate())&to=\(String(describing: AppConstants.getLastDateOfCurrentMonth()))"
    
    static let upCommingEventsBasketballFixtures  = "\(baseUrl)/basketball/?met=Fixtures&APIkey=\(apiKey)&from=\(AppConstants.getNowDate())&to=\(String(describing: AppConstants.getLastDateOfCurrentMonth()))"
    
    static let upCommingEventsCricketFixtures = "\(baseUrl)/cricket/?met=Fixtures&APIkey=\(apiKey)&from=\(AppConstants.getNowDate())&to=\(String(describing: AppConstants.getLastDateOfCurrentMonth()))"
    
    static let upCommingEventsTennisFixturesUpCommingEvents  = "\(baseUrl)/tennis/?met=Fixtures&APIkey=\(apiKey)&from=\(AppConstants.getNowDate())&to=\(String(describing: AppConstants.getLastDateOfCurrentMonth()))"
    
///FIXTURES  LATEST EVENT
    
    static let latestEventsFootballFixtures  = "\(baseUrl)/football/?met=Fixtures&APIkey=\(apiKey)&from=\(String(describing: AppConstants.getFirstDateOfCurrentMonth()))&to=\(String(describing:  AppConstants.getNowDate()))"
    
    static let latestEventsBasketballFixtures  = "\(baseUrl)/basketball/?met=Fixtures&APIkey=\(apiKey)&from=\(String(describing: AppConstants.getFirstDateOfCurrentMonth()))&to=\(String(describing:  AppConstants.getNowDate()))"
    
    static let latestEventsCricketFixtures  = "\(baseUrl)/cricket/?met=Fixtures&APIkey=\(apiKey)&from=\(String(describing: AppConstants.getFirstDateOfCurrentMonth()))&to=\(String(describing:  AppConstants.getNowDate()))"
    
    static let latestEventsTennisFixtures  = "\(baseUrl)/tennis/?met=Fixtures&APIkey=\(apiKey)&from=\(String(describing: AppConstants.getFirstDateOfCurrentMonth()))&to=\(String(describing:  AppConstants.getNowDate()))"
    
    
    
    
}



