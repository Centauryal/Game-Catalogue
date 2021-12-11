//
//  File.swift
//  
//
//  Created by Alfa Centaury Hidayatullah on 07/12/21.
//

import Foundation
import CoreData

public class ModuleProvider {
    public static let sharedManager = ModuleProvider()
    private init() {}
    
    lazy public var persistanContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "GamesCatalogue")
        container.loadPersistentStores { _, error in
            guard error == nil else {
                fatalError("Unresolved error \(error!)")
            }
        }
        
        container.viewContext.automaticallyMergesChangesFromParent = false
        container.viewContext.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
        container.viewContext.shouldDeleteInaccessibleFaults = true
        container.viewContext.undoManager = nil
        
        return container
    }()
    
    public func newTaskContext(_ persistanContainer: NSPersistentContainer) -> NSManagedObjectContext {
        let taskContext = persistanContainer.newBackgroundContext()
        taskContext.undoManager = nil
        taskContext.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
        
        return taskContext
    }
}
