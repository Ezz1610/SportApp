//
//  AppConstants.swift
//  SportApp
//
//  Created by mohamed ezz on 20/09/2025.
//

import Foundation

class AppConstants {
    static let baseUrl = "https://apiv2.allsportsapi.com"

    static var apiKey : String = "2120f2f312d80b0c590180019e76e23dd650d20e9d0df7f0e778e0d0e6afc9bd"

    private static let calendar = Calendar.current

    // MARK: - Public Methods

    /// Returns the current date
    static func getNowDate() -> Date {
        return Date()
    }

    /// Returns the first day of the current month
    static func getFirstDateOfCurrentMonth() -> Date? {
        let now = Date()
        let components = calendar.dateComponents([.year, .month], from: now)
        return calendar.date(from: components) ?? now
    }

    /// Returns the last day of the current month
    static func getLastDateOfCurrentMonth() -> Date? {
        guard let firstDay = getFirstDateOfCurrentMonth() else { return nil }
        
        var offset = DateComponents()
        offset.month = 1
        offset.day = -1
        
        return calendar.date(byAdding: offset, to: firstDay) ?? firstDay
    }

    /// Helper: Formats a Date into "yy-MM-dd"
    static func formatDate(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yy-MM-dd"
        formatter.timeZone = TimeZone.current
        return formatter.string(from: date)
    }
}
