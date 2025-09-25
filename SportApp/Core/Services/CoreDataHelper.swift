//
//  CoreDataHelper.swift
//  SportApp
//
//  Created by mohamed ezz on 21/09/2025.
//

import Foundation
import CoreData
import UIKit

final class CoreDataHelper {

    static let shared = CoreDataHelper()

    private let persistentContainer: NSPersistentContainer

    private init(container: NSPersistentContainer = (UIApplication.shared.delegate as! AppDelegate).persistentContainer) {
        self.persistentContainer = container
    }

    private var context: NSManagedObjectContext {
        return persistentContainer.viewContext
    }
    
    var viewContext: NSManagedObjectContext {
        return context
    }

    // MARK: - Save Generic Models
//    func saveAll<T: CoreDataConvertible>(_ models: [T]) {
//        for model in models {
//            _ = model.toManagedObject(in: context)
//        }
//
//        saveContext()
//        print("Saved \(models.count) \(T.self) items")
//    }
//    
//    func save<T: CoreDataConvertible>(_ model: T?) {
//       
//        _ = model?.toManagedObject(in: context)
//    
//
//        saveContext()
//        print("Saved \(model) \(T.self) items")
//    }
    
    func saveLeague(league: League){
        guard let entity = NSEntityDescription.entity(forEntityName: "CDLeague", in: context) else {
                    print("❌ Failed to create entity: Movie")
                    return
                }
                
                let leagueEntity = NSManagedObject(entity: entity, insertInto: context)
        leagueEntity.setValue(league.league_name, forKey: "leagueName")
        leagueEntity.setValue(league.league_key, forKey: "leagueKey")
        leagueEntity.setValue(league.league_surface, forKey: "leagueSurface")
        leagueEntity.setValue(league.league_logo, forKey: "leagueLogo")
        leagueEntity.setValue(league.country_key, forKey: "countryKey")
        leagueEntity.setValue(league.country_name, forKey: "countryName")
                do {
                    try context.save()
                    print("✅ Context saved")
                } catch {
                    print("❌ Save failed: \(error.localizedDescription)")
                }
        
        
    }
    func saveFixture(fixture: Fixture) {
        guard let entity = NSEntityDescription.entity(forEntityName: "CDFixture", in: context) else {
            print("Failed to create entity: CDFixture")
            return
        }

        let fixtureEntity = NSManagedObject(entity: entity, insertInto: context)

        fixtureEntity.setValue(String(fixture.eventKey), forKey: "eventKey")
        fixtureEntity.setValue(fixture.eventDate, forKey: "eventDate")
        fixtureEntity.setValue(fixture.eventTime, forKey: "eventTime")
        fixtureEntity.setValue(fixture.eventHomeTeam, forKey: "eventHomeTeam")
        fixtureEntity.setValue(String(fixture.homeTeamKey), forKey: "homeTeamKey")
        fixtureEntity.setValue(fixture.eventAwayTeam, forKey: "eventAwayTeam")
        fixtureEntity.setValue(String(fixture.awayTeamKey), forKey: "awayTeamKey")
        fixtureEntity.setValue(fixture.eventFinalResult, forKey: "eventFinalResult")
        fixtureEntity.setValue(fixture.eventStatus, forKey: "eventStatus")
        fixtureEntity.setValue(fixture.countryName, forKey: "countryName")
        fixtureEntity.setValue(fixture.leagueName, forKey: "leagueName")
        fixtureEntity.setValue(String(fixture.leagueKey), forKey: "leagueKey")
        fixtureEntity.setValue(fixture.leagueRound, forKey: "leagueRound")
        fixtureEntity.setValue(fixture.leagueSeason, forKey: "leagueSeason")
        fixtureEntity.setValue(fixture.eventLive, forKey: "eventLive")

        // Optional values
        fixtureEntity.setValue(fixture.awayTeamLogo, forKey: "eventAwayTeamLogo") // If this attribute exists
        fixtureEntity.setValue(fixture.homeTeamLogo, forKey: "eventHomeTeamLogo") // If this attribute exists
        fixtureEntity.setValue(fixture.eventHalftimeResult, forKey: "eventHalftimeResult") // If this attribute exists
        fixtureEntity.setValue(fixture.eventFtResult, forKey: "eventFtResult") // If this attribute exists

        do {
            try context.save()
            print("Fixture saved successfully")
        } catch {
            print("Failed to save fixture: \(error.localizedDescription)")
        }
    }

    func saveStanding(standing: Standing) {
        guard let entity = NSEntityDescription.entity(forEntityName: "CDStanding", in: context) else {
            print("Failed to create entity: CDStanding")
            return
        }

        let standingEntity = NSManagedObject(entity: entity, insertInto: context)

        // Safely unwrap and assign optional values
        standingEntity.setValue(standing.teamLogo, forKey: "teamLogo")
        standingEntity.setValue(standing.teamKey.map { NSNumber(value: $0) }, forKey: "teamKey")
        standingEntity.setValue(standing.standingUpdated, forKey: "standingUpdated")
        standingEntity.setValue(standing.standingTeam, forKey: "standingTeam")
        standingEntity.setValue(standing.standingPlaceType, forKey: "standingPlaceType")
        standingEntity.setValue(standing.standingPlace.map { NSNumber(value: $0) }, forKey: "standingPlace")
        standingEntity.setValue(standing.stageName, forKey: "stageName")
        standingEntity.setValue(standing.leagueSeason, forKey: "leagueSeason")
        standingEntity.setValue(standing.leagueRound, forKey: "leagueRound")
        standingEntity.setValue(standing.leagueKey.map { NSNumber(value: $0) }, forKey: "leagueKey")
        standingEntity.setValue(standing.fkStageKey.map { NSNumber(value: $0) }, forKey: "fkStageKey")

        do {
            try context.save()
            print("Standing saved successfully")
        } catch {
            print("Failed to save standing: \(error.localizedDescription)")
        }
    }

    // MARK: - Delete All for Entity Type
    func delete<T: NSManagedObject>(_ type: T.Type) {
        let entityName = String(describing: type)
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)

        do {
            try context.execute(deleteRequest)
            try context.save()
            print("Deleted all \(entityName)")
        } catch {
            print("Failed to delete \(entityName): \(error.localizedDescription)")
        }
    }
    //#####################################################
    private func mapFixture(from object: NSManagedObject) -> Fixture {
        Fixture(
            eventKey: Int(object.value(forKey: "eventKey") as? String ?? "") ?? 0,
            eventDate: object.value(forKey: "eventDate") as? String ?? "",
            eventTime: object.value(forKey: "eventTime") as? String ?? "",
            eventHomeTeam: object.value(forKey: "eventHomeTeam") as? String ?? "",
            homeTeamKey: Int(object.value(forKey: "homeTeamKey") as? String ?? "") ?? 0,
            eventAwayTeam: object.value(forKey: "eventAwayTeam") as? String ?? "",
            awayTeamKey: Int(object.value(forKey: "awayTeamKey") as? String ?? "") ?? 0,
            eventFinalResult: object.value(forKey: "eventFinalResult") as? String,
            eventStatus: object.value(forKey: "eventStatus") as? String ?? "",
            countryName: object.value(forKey: "countryName") as? String ?? "",
            leagueName: object.value(forKey: "leagueName") as? String ?? "",
            leagueKey: Int(object.value(forKey: "leagueKey") as? String ?? "") ?? 0,
            leagueRound: object.value(forKey: "leagueRound") as? String,
            leagueSeason: object.value(forKey: "leagueSeason") as? String ?? "",
            eventLive: object.value(forKey: "eventLive") as? String ?? "",
            homeTeamLogo: object.value(forKey: "eventHomeTeamLogo") as? String ?? "",
            awayTeamLogo: object.value(forKey: "eventAwayTeamLogo") as? String,
            eventHalftimeResult: object.value(forKey: "eventHalftimeResult") as? String,
            eventFtResult: object.value(forKey: "eventFtResult") as? String
        )
    }
    func getLeagues() -> [League] {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "CDLeague")

        do {
            let results = try context.fetch(fetchRequest) as? [NSManagedObject] ?? []
            return results.map { obj in
                League(
                    league_key: obj.value(forKey: "leagueKey") as? Int ?? 0,
                    league_name: obj.value(forKey: "leagueName") as? String ?? "",
                    country_key: obj.value(forKey: "countryKey") as? Int ?? 0, country_name: obj.value(forKey: "countryName") as? String ?? "", league_surface: obj.value(forKey: "leagueSurface") as? String ?? "",
                    league_logo: obj.value(forKey: "leagueLogo") as? String ?? ""
                )
            }
        } catch {
            print("Failed to fetch leagues: \(error.localizedDescription)")
            return []
        }
    }
    func getStandings() -> [Standing] {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "CDStanding")

        do {
            let results = try context.fetch(fetchRequest) as? [NSManagedObject] ?? []
            return results.map { obj in
                Standing(
                    standingPlace: (obj.value(forKey: "standingPlace") as? NSNumber)?.intValue,
                    standingPlaceType: obj.value(forKey: "standingPlaceType") as? String,
                    standingTeam: obj.value(forKey: "standingTeam") as? String,
                    teamKey: (obj.value(forKey: "teamKey") as? NSNumber)?.intValue,
                    leagueKey: (obj.value(forKey: "leagueKey") as? NSNumber)?.intValue,
                    leagueSeason: obj.value(forKey: "leagueSeason") as? String,
                    leagueRound: obj.value(forKey: "leagueRound") as? String,
                    standingUpdated: obj.value(forKey: "standingUpdated") as? String,
                    fkStageKey: (obj.value(forKey: "fkStageKey") as? NSNumber)?.intValue,
                    stageName: obj.value(forKey: "stageName") as? String,
                    teamLogo: obj.value(forKey: "teamLogo") as? String
                )
            }
        } catch {
            print("Failed to fetch standings: \(error.localizedDescription)")
            return []
        }
    }



    func getUpcomingFixtures() -> [Fixture] {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "CDFixture")
        fetchRequest.predicate = NSPredicate(format: "eventStatus != %@", "Finished")

        do {
            let results = try context.fetch(fetchRequest) as? [NSManagedObject] ?? []
            return results.map(mapFixture)
        } catch {
            print("Failed to fetch upcoming fixtures: \(error.localizedDescription)")
            return []
        }
    }
    func getLatestFixtures() -> [Fixture] {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "CDFixture")
        fetchRequest.predicate = NSPredicate(format: "eventStatus == %@", "Finished")

        do {
            let results = try context.fetch(fetchRequest) as? [NSManagedObject] ?? []
            return results.map(mapFixture)
        } catch {
            print("Failed to fetch latest fixtures: \(error.localizedDescription)")
            return []
        }
    }


    // MARK: - Fetch All of Entity Type
    func fetch<T: NSManagedObject>(_ type: T.Type) -> [T] {
        let request = NSFetchRequest<T>(entityName: String(describing: type))
        do {
            return try context.fetch(request)
        } catch {
            print("Fetch failed for \(T.self): \(error.localizedDescription)")
            return []
        }
    }

    // MARK: - Save Context
    private func saveContext() {
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                print("Core Data save failed: \(error.localizedDescription)")
            }
        }
    }
}
