//
//  StandingsTeamsRequest.swift
//  SportApp
//
//  Created by mohamed ezz on 20/09/2025.
//

import Foundation

struct StandingsTeamsResponse: Decodable {
    let success: Int
    let result: StandingsResult
}

struct StandingsResult: Decodable {
    let total: [Standing]
}

struct Standing: Decodable {
//    let standingPlace: Int
//    let standingPlaceType: String
//    let standingTeam: String
//    let teamKey: Int
//    let leagueKey: Int
//    let leagueSeason: String
//    let leagueRound: String?
//    let standingUpdated: String
//    let fkStageKey: Int
//    let stageName: String
//    let teamLogo: String
    let standingPlace: Int
    let standingPlaceType: String
    let standingTeam: String
    let teamKey: Int
    let leagueKey: Int
    let leagueSeason: String
    let leagueRound: String
    let standingUpdated: String
    let fkStageKey: Int
    let stageName: String
    let teamLogo: String

}
