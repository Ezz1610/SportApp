//
//  TeamSection.swift
//  SportApp
//
//  Created by Nafea Elkassas on 24/09/2025.
//

import Foundation
struct TeamSection {
    let type: TeamSectionType
    let items: [Any]
}

struct TeamDetailsResponse: Codable {
    let success: Int
    let result: [TeamDetails]
}

struct TeamDetails: Codable {
    let teamKey: Int?
    let teamName: String?
    let teamLogo: String?
    let players: [Player]?
    let coaches: [Coach]?
    
    enum CodingKeys: String, CodingKey {
        case teamKey = "team_key"
        case teamName = "team_name"
        case teamLogo = "team_logo"
        case players = "players"
        case coaches = "coaches"
    }
}
