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
