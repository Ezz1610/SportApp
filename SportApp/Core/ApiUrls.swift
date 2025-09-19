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

//larg data
//https://apiv2.allsportsapi.com/basketball/?met=Fixtures&APIkey=2120f2f312d80b0c590180019e76e23dd650d20e9d0df7f0e778e0d0e6afc9bd&from=209-05-23&to=2019-05-23


//
//"event_key": "41223",
//     "event_date": "2022-04-21",
//     "event_time": "01:00",
//     "event_home_team": "Boston Celtics",
//     "home_team_key": "7",
//     "event_away_team": "Brooklyn Nets",
//     "away_team_key": "2",
//     "event_final_result": "114 - 107",
//     "event_quarter": "",
//     "event_status": "Finished",
//     "country_name": "USA",
//     "league_name": "NBA",
//     "league_key": "766",
//     "league_round": null,
//     "league_season": "2021/2022",
//     "event_live": "0",
//     "event_home_team_logo": "https://apiv2.allsportsapi.com/logo-basketball/7_boston_celtics.jpg",
//     "event_away_team_logo": null,
