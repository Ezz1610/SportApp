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
    
    enum CodingKeys: String, CodingKey {
        case playerName = "player_name"
        case playerType = "player_type"
        case playerImage = "player_image"
    }
}
