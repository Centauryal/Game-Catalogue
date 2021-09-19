//
//  GameProvider.swift
//  gamescatalogue
//
//  Created by Alfa Centaury on 13/09/21.
//

import Foundation
import CoreData

class GameProvider {
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
    
    private func newTaskContext() -> NSManagedObjectContext {
        let taskContext = persistanContainer.newBackgroundContext()
        taskContext.undoManager = nil
        taskContext.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
        
        return taskContext
    }
    
    func getAllFavoriteGames(completion: @escaping(_ games: [GameModel]) -> Void) {
        let  taskContext = newTaskContext()
        taskContext.perform {
            let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Games")
            do {
                let results = try taskContext.fetch(fetchRequest)
                var games: [GameModel] = []
                for result in results {
                    let game = GameModel(
                        id: result.value(forKey: "id") as? Int32,
                        name: result.value(forKey: "name") as? String,
                        image: result.value(forKey: "image") as? String,
                        imageBackground: result.value(forKey: "imagebackground") as? String,
                        desc: result.value(forKey: "desc") as? String,
                        releaseDate: result.value(forKey: "releasedate") as? String,
                        genre: result.value(forKey: "genre") as? String,
                        platform: result.value(forKey: "platform") as? String,
                        publisher: result.value(forKey: "publisher") as? String,
                        rating: result.value(forKey: "rating") as? Double
                    )
                    
                    games.append(game)
                }
                completion(games)
            } catch let error as NSError {
                print("Could not fetch. \(error), \(error.userInfo)")
            }
        }
    }
    
    func getFavoriteGame(_ id: Int, completion: @escaping(_ games: GameModel) -> Void) {
        let taskContext = newTaskContext()
        taskContext.perform {
            let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Games")
            fetchRequest.fetchLimit = 1
            fetchRequest.predicate = NSPredicate(format: "id == \(id)")
            do {
                if let result = try taskContext.fetch(fetchRequest).first {
                    let game = GameModel(
                        id: result.value(forKey: "id") as? Int32,
                        name: result.value(forKey: "name") as? String,
                        image: result.value(forKey: "image") as? String,
                        imageBackground: result.value(forKey: "imagebackground") as? String,
                        desc: result.value(forKey: "desc") as? String,
                        releaseDate: result.value(forKey: "releasedate") as? String,
                        genre: result.value(forKey: "genre") as? String,
                        platform: result.value(forKey: "platform") as? String,
                        publisher: result.value(forKey: "publisher") as? String,
                        rating: result.value(forKey: "rating") as? Double
                    )
                    
                    completion(game)
                }
            } catch let error as NSError {
                print("Could not fetch. \(error), \(error.userInfo)")
            }
        }
    }
    
    func setFavoriteGame(
        _ id: Int,
        _ name: String,
        _ image: String,
        _ imageBackground: String,
        _ desc: String,
        _ releaseDate: String,
        _ genre: String,
        _ platform: String,
        _ publisher: String,
        _ rating: Double,
        completion: @escaping() -> Void
        ) {
        let taskContext = newTaskContext()
        taskContext.perform {
            if let entity = NSEntityDescription.entity(forEntityName: "Games", in: taskContext) {
                let game = NSManagedObject(entity: entity, insertInto: taskContext)
                game.setValue(id, forKey: "id")
                game.setValue(name, forKey: "name")
                game.setValue(image, forKey: "image")
                game.setValue(imageBackground, forKey: "imagebackground")
                game.setValue(desc, forKey: "desc")
                game.setValue(releaseDate, forKey: "releasedate")
                game.setValue(genre, forKey: "genre")
                game.setValue(platform, forKey: "platform")
                game.setValue(publisher, forKey: "publisher")
                game.setValue(rating, forKey: "rating")
                
                do {
                    try taskContext.save()
                    completion()
                } catch let error as NSError {
                    print("Could not save. \(error), \(error.userInfo)")
                }
            }
        }
    }
    
    func deleteAllFavoriteGames(completion: @escaping() -> Void) {
        let taskContext = newTaskContext()
        taskContext.perform {
            let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Games")
            let batchDeleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
            batchDeleteRequest.resultType = .resultTypeCount
            
            if let batchDeleteResult = try? taskContext.execute(batchDeleteRequest) as? NSBatchDeleteResult {
                if batchDeleteResult.result != nil {
                    completion()
                }
            }
        }
    }
    
    func deleteFavoriteGame(_ id: Int, completion: @escaping() -> Void) {
        let taskContext = newTaskContext()
        taskContext.perform {
            let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Games")
            fetchRequest.fetchLimit = 1
            fetchRequest.predicate = NSPredicate(format: "id == \(id)")
            let batchDeleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
            batchDeleteRequest.resultType = .resultTypeCount
            
            if let batchDeleteResult = try? taskContext.execute(batchDeleteRequest) as? NSBatchDeleteResult {
                if batchDeleteResult.result != nil {
                    completion()
                }
            }
        }
    }
}
