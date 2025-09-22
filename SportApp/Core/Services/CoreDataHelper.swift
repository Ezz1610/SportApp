//
//  CoreDataHelper.swift
//  SportApp
//
//  Created by mohamed ezz on 21/09/2025.
//

import UIKit
import CoreData


class CoreDataHelper {
    
    static let shared = CoreDataHelper()
    
    private init() {}
    
    var context: NSManagedObjectContext {
        return (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    }

    // MARK: - Generic Save
    func save<T: CoreDataConvertible>(models: [T]) {
        for model in models {
            _ = model.toManagedObject(in: context)
        }
        
        do {
            try context.save()
            print("Saved \(models.count) \(T.self) items")
        } catch {
            print("Core Data save failed: \(error)")
        }
    }

    // MARK: - Delete All Entities by Name
    func deleteAllEntities(named entityName: String) {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
        
        do {
            try context.execute(deleteRequest)
            try context.save()
            print("Deleted all \(entityName)")
        } catch {
            print("Failed to delete \(entityName): \(error)")
        }
    }
}
