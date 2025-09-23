//
//  FixtureModel.swift
//  SportApp
//
//  Created by mohamed ezz on 19/09/2025.
//

import Foundation

struct FixturesRequest : Decodable{
    var result : [Fixture]
    var success : Int
}


struct Fixture: Decodable {
    let eventKey: Int
    let eventDate: String
    let eventTime: String
    let eventHomeTeam: String
    let homeTeamKey: Int
    let eventAwayTeam: String
    let awayTeamKey: Int
    let eventFinalResult: String?
    let eventStatus: String
    let countryName: String
    let leagueName: String
    let leagueKey: Int
    let leagueRound: String?
    let leagueSeason: String
    let eventLive: String
    let homeTeamLogo: String
    let awayTeamLogo: String?
    let eventHalftimeResult: String?
    let eventFtResult: String?
    
    private enum CodingKeys: String, CodingKey {
        case eventKey = "event_key"
        case eventDate = "event_date"
        case eventTime = "event_time"
        case eventHomeTeam = "event_home_team"
        case homeTeamKey = "home_team_key"
        case eventAwayTeam = "event_away_team"
        case awayTeamKey = "away_team_key"
        case eventFinalResult = "event_final_result"
        case eventStatus = "event_status"
        case countryName = "country_name"
        case leagueName = "league_name"
        case leagueKey = "league_key"
        case leagueRound = "league_round"
        case leagueSeason = "league_season"
        case eventLive = "event_live"
        case homeTeamLogo = "home_team_logo"
        case awayTeamLogo = "away_team_logo"
        case eventHalftimeResult = "event_halftime_result"
        case eventFtResult = "event_ft_result"
    }
}


