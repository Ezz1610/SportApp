//
//  FixtureModel.swift
//  SportApp
//
//  Created by mohamed ezz on 19/09/2025.
//

import Foundation

struct FixturesResponse : Decodable{
    var result : [Fixture]
    var success : Int
}


struct Fixture: Decodable {
    let eventKey: Int?
    let eventDate: String?
    let eventDateStart: String?
    let eventDateStop: String?
    let eventTime: String?
    
    // Football/Basketball
    let eventHomeTeam: String?
    let homeTeamKey: Int?
    let eventAwayTeam: String?
    let awayTeamKey: Int?
    
    // Tennis
    let eventFirstPlayer: String?
    let firstPlayerKey: Int?
    let eventSecondPlayer: String?
    let secondPlayerKey: Int?
    
    // Cricket
    let eventHomeFinalResult: String?
    let eventAwayFinalResult: String?
    
    let eventFinalResult: String?
    let eventStatus: String?
    let countryName: String?
    let leagueName: String?
    let leagueKey: Int?
    let leagueRound: String?
    let leagueSeason: String?
    let eventLive: String?
    
    let homeTeamLogoFootball: String? // for football
    let awayTeamLogoFootball: String?
    let homeTeamLogoBasketball: String? // for basketball
    let awayTeamLogoBasketball: String?
    let eventFirstPlayerLogo: String?
    let eventSecondPlayerLogo: String?

    
    private enum CodingKeys: String, CodingKey {
        case eventKey = "event_key"
        case eventDate = "event_date"
        case eventDateStart = "event_date_start"
        case eventDateStop = "event_date_stop"
        case eventTime = "event_time"
        case eventHomeTeam = "event_home_team"
        case homeTeamKey = "home_team_key"
        case eventAwayTeam = "event_away_team"
        case awayTeamKey = "away_team_key"
        case eventFirstPlayer = "event_first_player"
        case firstPlayerKey = "first_player_key"
        case eventSecondPlayer = "event_second_player"
        case secondPlayerKey = "second_player_key"
        case eventFinalResult = "event_final_result"
        case eventHomeFinalResult = "event_home_final_result"
        case eventAwayFinalResult = "event_away_final_result"
        case eventStatus = "event_status"
        case countryName = "country_name"
        case leagueName = "league_name"
        case leagueKey = "league_key"
        case leagueRound = "league_round"
        case leagueSeason = "league_season"
        case eventLive = "event_live"
        case homeTeamLogoFootball = "home_team_logo"
        case awayTeamLogoFootball = "away_team_logo"
        case homeTeamLogoBasketball = "event_home_team_logo"
        case awayTeamLogoBasketball = "event_away_team_logo"
        case eventFirstPlayerLogo = "event_first_player_logo"
        case eventSecondPlayerLogo = "event_second_player_logo"

    }
    
    // MARK: - Computed Properties for Normalization
    
    var displayHomeName: String {
        return eventHomeTeam ?? eventFirstPlayer ?? "Unknown"
    }
    
    var displayAwayName: String {
        return eventAwayTeam ?? eventSecondPlayer ?? "Unknown"
    }
    
    var displayResult: String {
        if let final = eventFinalResult, !final.isEmpty { return final }
        if let home = eventHomeFinalResult, let away = eventAwayFinalResult {
            return "\(home) - \(away)"
        }
        return "-"
    }
    
    var displayHomeLogo: String? {
          return homeTeamLogoFootball ?? homeTeamLogoBasketball ?? eventFirstPlayerLogo
      }
      
      var displayAwayLogo: String? {
          return awayTeamLogoFootball ?? awayTeamLogoBasketball ?? eventSecondPlayerLogo
      }
    
    var displayDate: String {
        return eventDate ?? eventDateStart ?? "Unknown Date"
    }
    
    var displayTime: String {
        return eventTime ?? "Unknown Time"
    }
}



