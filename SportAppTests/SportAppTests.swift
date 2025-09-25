//
//  SportAppTests.swift
//  SportAppTests
//
//  Created by mohamed ezz on 15/09/2025.
//

import XCTest
@testable import SportApp

final class SportAppTests: XCTestCase {
    var networkService = NetworkService()

    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        // Any test you write for XCTest can be annotated as throws and async.
        // Mark your test throws to produce an unexpected failure when your test encounters an uncaught error.
        // Mark your test async to allow awaiting for asynchronous code to complete. Check the results with assertions afterwards.
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    func testFetchFootballLeagues() {
           let exp = expectation(description: "Fetching football leagues using static fetchData")

           // URL and query items
           let url = ApiUrls.football
           let queryItems = [
            URLQueryItem(name: "met", value: "Leagues"),
               URLQueryItem(name: "APIkey", value: AppConstants.apiKey)
           ]

           // Call the static fetch function
           NetworkService.fetchData(from: url, queryItems: queryItems) { (result: Result<SprortsLeagueResponse, Error>) in
               switch result {
               case .success(let response):
                   XCTAssertEqual(response.success, 1)
                   XCTAssertFalse(response.result.isEmpty, "Leagues should not be empty")
                   print("Fetched \(response.result.count) leagues.")
               case .failure(let error):
                   XCTFail("Network error: \(error.localizedDescription)")
               }
               exp.fulfill()
           }

           waitForExpectations(timeout: 10)
       }
    
    func testFetchUpcomingFootballFixtures() {
        let exp = expectation(description: "Fetching upcoming football fixtures")
   
        let url = ApiUrls.football
        let queryItems = [
            URLQueryItem(name: "met", value: "Fixtures"),
            URLQueryItem(name: "APIkey", value: AppConstants.apiKey),
            URLQueryItem(name: "from", value: "2025-09-25"),
            URLQueryItem(name: "to", value: "2025-09-30"),
            URLQueryItem(name: "leagueId", value:"4")

        ]

        NetworkService.fetchData(from: url, queryItems: queryItems) { (result: Result<FixturesResponse, Error>) in
            switch result {
            case .success(let response):
                XCTAssertEqual(response.success, 1, "API should return success: 1")
                XCTAssertNotNil(response.result, "Result should not be nil")
                XCTAssertFalse(response.result.isEmpty, "Fixtures list should not be empty")

                        case .failure(let error):
                XCTFail("Error: \(error.localizedDescription)")
            }
            exp.fulfill()
        }

        waitForExpectations(timeout: 15)
    }

    func testFetchLatestFootballFixtures() {
        let exp = expectation(description: "Fetching upcoming football fixtures")
   
        let url = ApiUrls.football
        let queryItems = [
            URLQueryItem(name: "met", value: "Fixtures"),
            URLQueryItem(name: "APIkey", value: AppConstants.apiKey),
            URLQueryItem(name: "from", value: "2025-09-20"),
            URLQueryItem(name: "to", value: "2025-09-25"),
            URLQueryItem(name: "leagueId", value:"4")

        ]

        NetworkService.fetchData(from: url, queryItems: queryItems) { (result: Result<FixturesResponse, Error>) in
            switch result {
            case .success(let response):
                XCTAssertEqual(response.success, 1, "API should return success: 1")
                XCTAssertNotNil(response.result, "Result should not be nil")
                XCTAssertFalse(response.result.isEmpty, "Fixtures list should not be empty")

                        case .failure(let error):
                XCTFail("Error: \(error.localizedDescription)")
            }
            exp.fulfill()
        }

        waitForExpectations(timeout: 15)
    }

    func testFetchFootballStandings() {
        let exp = expectation(description: "Fetching football standings")

        let leagueId = 4  // Replace with a valid league ID, e.g., Premier League

        let queryItems = [
            URLQueryItem(name: "met", value: "Standings"),
            URLQueryItem(name: "APIkey", value: AppConstants.apiKey),
            URLQueryItem(name: "leagueId", value: "\(leagueId)")
        ]

        let url = ApiUrls.football // This will be "https://apiv2.allsportsapi.com/football/"

        NetworkService.fetchData(from: url, queryItems: queryItems) { (result: Result<StandingsTeamsResponse, Error>) in
            switch result {
            case .success(let response):
                XCTAssertEqual(response.success, 1, "API should return success: 1")
                XCTAssertFalse(response.result.total.isEmpty, "Standings should not be empty")
                print("Fetched standings for league \(leagueId): \(response.result.total.count) teams")
            case .failure(let error):
                XCTFail("API error: \(error.localizedDescription)")
            }
            exp.fulfill()
        }

        waitForExpectations(timeout: 10)
    }
}
