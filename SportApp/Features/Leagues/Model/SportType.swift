//
//  SportType.swift
//  SportApp
//
//  Created by Nafea Elkassas on 18/09/2025.
//

import Foundation
enum SportType: String {
        case football = "football"
        case basketball = "basketball"
        case tennis = "tennis"
        case cricket = "cricket"
    
    init?(rawValueInsensitive value: String?) {
        guard let value = value?.lowercased() else { return nil }
        self.init(rawValue: value)
    }
}
