//
//  File.swift
//  SportApp
//
//  Created by mohamed ezz on 21/09/2025.
//

import CoreData
import Foundation
protocol CoreDataConvertible {
    associatedtype Entity: NSManagedObject
    func toManagedObject(in context: NSManagedObjectContext) -> Entity
}
