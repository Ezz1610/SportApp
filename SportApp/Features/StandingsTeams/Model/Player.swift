//
//  Player.swift
//  SportApp
//
//  Created by Nafea Elkassas on 24/09/2025.
//

import Foundation
struct Player: Codable {
    let playerName: String?
    let playerType: String?
    let playerImage: String?
    let playerNumber: String?     
    let playerCountry: String?
    let playerAge: String?
    let playerIsCaptain: String?
    let teamName: String?

    enum CodingKeys: String, CodingKey {
        case playerName = "player_name"
        case playerType = "player_type"
        case playerImage = "player_image"
        case playerNumber = "player_number"
        case playerCountry = "player_country"
        case playerAge = "player_age"
        case playerIsCaptain = "player_is_captain"
        case teamName = "team_name"
    }
}
