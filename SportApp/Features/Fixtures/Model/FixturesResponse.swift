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
    let eventKey: String
    let eventDate: String
    let eventTime: String
    let eventHomeTeam: String
    let homeTeamKey: String
    let eventAwayTeam: String
    let awayTeamKey: String
    let eventFinalResult: String
    let eventQuarter: String?
    let eventStatus: String // "event_status":"Finished" => latest || "event_status":"" => upcoming events
    let countryName: String
    let leagueName: String
    let leagueKey: String
    let leagueRound: String?
    let leagueSeason: String
    let eventLive: String
    let eventHomeTeamLogo: String
    let eventAwayTeamLogo: String?
}
