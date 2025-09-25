//
//  CoreDataToLeague.swift
//  SportApp
//
//  Created by Nafea Elkassas on 25/09/2025.
//

import Foundation
extension CDLeague {
    func toLeague() -> League {
        let normalizedSport = SportType(rawValueInsensitive: self.selectedSport)
        
        return League(
            league_key: Int(self.leagueKey),
            league_name: self.leagueName,
            country_key: Int(self.countryKey),
            country_name: self.countryName,
            league_surface: self.leagueSurface,
            league_logo: self.leagueLogo,
            sportType: normalizedSport
        )
    }
}
