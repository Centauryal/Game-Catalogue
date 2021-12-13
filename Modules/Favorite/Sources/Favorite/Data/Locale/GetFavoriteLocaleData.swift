//
//  File.swift
//  
//
//  Created by Alfa Centaury on 06/12/21.
//

import Foundation
import Core
import CoreData
import Combine

public struct GetFavoriteLocaleData: LocaleDataSource {
    
    public typealias Request = Any
    public typealias Response = FavoriteModuleEntity
    
    private let _newTaskContext: NSManagedObjectContext
    
    public init(persistenceContainer: NSPersistentContainer) {
        self._newTaskContext = ModuleProvider.sharedManager.newTaskContext(persistenceContainer)
    }
    
    public func getAllList(request: Any?) -> AnyPublisher<[FavoriteModuleEntity], Error> {
        return Future<[FavoriteModuleEntity], Error> { completion in
            let taskContext = self._newTaskContext
            taskContext.perform {
                let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Games")
                do {
                    let results = try taskContext.fetch(fetchRequest)
                    var games: [FavoriteModuleEntity] = []
                    for result in results {
                        let game = FavoriteModuleEntity(
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
                    completion(.success(games))
                } catch {
                    completion(.failure(LocaleError.invalidInstance))
                }
            }
        }.eraseToAnyPublisher()
    }
    
    public func getById(_ id: Int) -> AnyPublisher<FavoriteModuleEntity, Error> {
        return Future<FavoriteModuleEntity, Error> { completion in
            let taskContext = self._newTaskContext
            taskContext.perform {
                let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Games")
                fetchRequest.fetchLimit = 1
                fetchRequest.predicate = NSPredicate(format: "id == \(id)")
                do {
                    if let result = try taskContext.fetch(fetchRequest).first {
                        let game = FavoriteModuleEntity(
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
                        
                        completion(.success(game))
                    }
                } catch {
                    completion(.failure(LocaleError.invalidInstance))
                }
            }
        }.eraseToAnyPublisher()
    }
    
    public func set(_ gameEntity: FavoriteModuleEntity) -> AnyPublisher<Bool, Error> {
        return Future<Bool, Error> { completion in
            let taskContext = self._newTaskContext
            if let entity = NSEntityDescription.entity(forEntityName: "Games", in: taskContext) {
                let game = NSManagedObject(entity: entity, insertInto: taskContext)
                game.setValue(Int(gameEntity.id!), forKey: "id")
                game.setValue(gameEntity.name, forKey: "name")
                game.setValue(gameEntity.image, forKey: "image")
                game.setValue(gameEntity.imageBackground, forKey: "imagebackground")
                game.setValue(gameEntity.desc, forKey: "desc")
                game.setValue(gameEntity.releaseDate, forKey: "releasedate")
                game.setValue(gameEntity.genre, forKey: "genre")
                game.setValue(gameEntity.platform, forKey: "platform")
                game.setValue(gameEntity.publisher, forKey: "publisher")
                game.setValue(gameEntity.rating, forKey: "rating")
                
                do {
                    try taskContext.save()
                    completion(.success(true))
                } catch {
                    completion(.failure(LocaleError.requestFailed))
                }
            }
        }.eraseToAnyPublisher()
    }
    
    public func deleteAll(request: Any?) -> AnyPublisher<Bool, Error> {
        return Future<Bool, Error> { completion in
            let taskContext = self._newTaskContext
            taskContext.perform {
                let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Games")
                let batchDeleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
                batchDeleteRequest.resultType = .resultTypeCount
                
                if let batchDeleteResult = try? taskContext.execute(batchDeleteRequest) as? NSBatchDeleteResult {
                    if batchDeleteResult.result != nil {
                        completion(.success(true))
                    } else {
                        completion(.failure(LocaleError.requestFailed))
                    }
                }
            }
        }.eraseToAnyPublisher()
    }
    
    public func deleteById(_ id: Int) -> AnyPublisher<Bool, Error> {
        return Future<Bool, Error> { completion in
            let taskContext = self._newTaskContext
            taskContext.perform {
                let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Games")
                fetchRequest.fetchLimit = 1
                fetchRequest.predicate = NSPredicate(format: "id == \(id)")
                let batchDeleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
                batchDeleteRequest.resultType = .resultTypeCount
                
                if let batchDeleteResult = try? taskContext.execute(batchDeleteRequest) as? NSBatchDeleteResult {
                    if batchDeleteResult.result != nil {
                        completion(.success(true))
                    } else {
                        completion(.failure(LocaleError.requestFailed))
                    }
                }
            }
        }.eraseToAnyPublisher()
    }
    
    public func loadUserDefault() -> AnyPublisher<FavoriteModuleEntity, Error> {
        fatalError()
    }
}
