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
    let standingPlace: Int?
    let standingPlaceType: String?
    let standingTeam: String?
    let teamKey: Int?
    let leagueKey: Int?
    let leagueSeason: String?
    let leagueRound: String?
    let standingUpdated: String?
    let fkStageKey: Int?
    let stageName: String?
    let teamLogo: String?
    
    enum CodingKeys: String, CodingKey {
        case standingPlace = "standing_place"
        case standingPlaceType = "standing_place_type"
        case standingTeam = "standing_team"
        case teamKey = "team_key"
        case leagueKey = "league_key"
        case leagueSeason = "league_season"
        case leagueRound = "league_round"
        case standingUpdated = "standing_updated"
        case fkStageKey = "fk_stage_key"
        case stageName = "stage_name"
        case teamLogo = "team_logo"
    }

}
