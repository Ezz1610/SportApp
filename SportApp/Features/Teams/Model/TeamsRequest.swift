//
//  Teams.swift
//  SportApp
//
//  Created by mohamed ezz on 20/09/2025.
//

import Foundation


struct TeamRequest: Decodable {
    let success: Int
    let result: [Team]
}

struct Team: Decodable {
    let teamKey: Int
    let teamName: String
    let teamLogo: String
    let players: [Player]


}

struct Player: Decodable {
    let playerKey: Int
    let playerImage: String?
    let playerName: String
    let playerNumber: String?
    let playerType: String

}
