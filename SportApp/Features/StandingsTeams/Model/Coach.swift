//
//  Coach.swift
//  SportApp
//
//  Created by Nafea Elkassas on 24/09/2025.
//

import Foundation
struct Coach: Codable {
    let coachName: String?
    let coachCountry: String?
    let coachAge: String?
    
    enum CodingKeys: String, CodingKey {
        case coachName = "coach_name"
        case coachCountry = "coach_country"
        case coachAge = "coach_age"
    }
}
