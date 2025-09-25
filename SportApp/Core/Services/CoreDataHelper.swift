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
    
    func saveLeague(league: League){
        guard let entity = NSEntityDescription.entity(forEntityName: "CDLeague", in: context) else {
            print("Failed to create entity: Movie")
            return
        }
        
        let leagueEntity = NSManagedObject(entity: entity, insertInto: context)
        leagueEntity.setValue(league.league_name, forKey: "leagueName")
        leagueEntity.setValue(league.league_key, forKey: "leagueKey")
        leagueEntity.setValue(league.league_surface, forKey: "leagueSurface")
        leagueEntity.setValue(league.league_logo, forKey: "leagueLogo")
        leagueEntity.setValue(league.country_key, forKey: "countryKey")
        leagueEntity.setValue(league.country_name, forKey: "countryName")
        
        // for sport type which doesn't come from api
        leagueEntity.setValue(league.sportType?.rawValue, forKey: "selectedSport")
        do {
            try context.save()
            print("Context saved")
        } catch {
            print("Save failed: \(error.localizedDescription)")
        }
    }

    // delete object from entity
    func deleteObject(_ object: NSManagedObject) {
        context.delete(object)
        do {
            try context.save()
            print("Deleted object: \(object)")
        } catch {
            print("Failed to delete object: \(error.localizedDescription)")
        }
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
