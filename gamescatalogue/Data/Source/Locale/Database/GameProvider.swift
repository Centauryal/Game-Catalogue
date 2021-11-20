//
//  GameProvider.swift
//  gamescatalogue
//
//  Created by Alfa Centaury on 13/09/21.
//

import Foundation
import CoreData

class GameProvider {
    static let sharedManager = GameProvider()
    private init() {}
    
    lazy var persistanContainer: NSPersistentContainer = {
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
    
    func newTaskContext(_ persistanContainer: NSPersistentContainer) -> NSManagedObjectContext {
        let taskContext = persistanContainer.newBackgroundContext()
        taskContext.undoManager = nil
        taskContext.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
        
        return taskContext
    }
}
