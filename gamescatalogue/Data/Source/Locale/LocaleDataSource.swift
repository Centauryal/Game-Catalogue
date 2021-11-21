//
//  LocaleDataSource.swift
//  gamescatalogue
//
//  Created by Alfa Centaury on 04/11/21.
//

import Foundation
import CoreData
import Combine

protocol LocaleDataSourceProtocol: AnyObject {
    func getAllFavorite() -> AnyPublisher<[GameEntity], Error>
    
    func getFavorite(_ id: Int) -> AnyPublisher<GameEntity, Error>
    
    func setFavorite(_ gameEntity: GameEntity) -> AnyPublisher<Bool, Error>
    
    func deleteAllFavorite() -> AnyPublisher<Bool, Error>
    
    func deleteFavorite(_ id: Int) -> AnyPublisher<Bool, Error>
    
    func loadUserAccount() -> AnyPublisher<AccountEntity, Error>
    
    func addUserAccount(_ accountEntity: AccountEntity) -> AnyPublisher<Bool, Error>
}

final class LocaleDataSource: NSObject {
    private let newTaskContext: NSManagedObjectContext
    private let userDefault: UserDefaults
    
    private init(persistanContainer: NSPersistentContainer) {
        self.newTaskContext = GameProvider.sharedManager.newTaskContext(persistanContainer)
        self.userDefault = AccountProvider.sharedManager.userDefaultsAccount()
    }
    
    static let sharedInstance: (NSPersistentContainer) -> LocaleDataSource = { database in
        return LocaleDataSource(persistanContainer: database)
    }
}

extension LocaleDataSource: LocaleDataSourceProtocol {
    func getAllFavorite() -> AnyPublisher<[GameEntity], Error> {
        return Future<[GameEntity], Error> { completion in
            let  taskContext = self.newTaskContext
            taskContext.perform {
                let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Games")
                do {
                    let results = try taskContext.fetch(fetchRequest)
                    var games: [GameEntity] = []
                    for result in results {
                        let game = GameEntity(
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
    
    func getFavorite(_ id: Int) -> AnyPublisher<GameEntity, Error> {
        return Future<GameEntity, Error> { completion in
            let taskContext = self.newTaskContext
            taskContext.perform {
                let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Games")
                fetchRequest.fetchLimit = 1
                fetchRequest.predicate = NSPredicate(format: "id == \(id)")
                do {
                    if let result = try taskContext.fetch(fetchRequest).first {
                        let game = GameEntity(
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
    
    func setFavorite(_ gameEntity: GameEntity) -> AnyPublisher<Bool, Error> {
        return Future<Bool, Error> { completion in
            let taskContext = self.newTaskContext
            taskContext.perform {
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
            }
        }.eraseToAnyPublisher()
    }
    
    func deleteAllFavorite() -> AnyPublisher<Bool, Error> {
        return Future<Bool, Error> { completion in
            let taskContext = self.newTaskContext
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
    
    func deleteFavorite(_ id: Int) -> AnyPublisher<Bool, Error> {
        return Future<Bool, Error> { completion in
            let taskContext = self.newTaskContext
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
    
    func loadUserAccount() -> AnyPublisher<AccountEntity, Error> {
        return Future<AccountEntity, Error> { completion in
            let user = self.userDefault
            
            do {
                let account = try user.getObject(forKey: "Account", castTo: AccountEntity.self)
                completion(.success(account))
            } catch {
                completion(.failure(LocaleError.requestFailed))
            }
        }.eraseToAnyPublisher()
    }
    
    func addUserAccount(_ accountEntity: AccountEntity) -> AnyPublisher<Bool, Error> {
        return Future<Bool, Error> { completion in
            let user = self.userDefault
            
            do {
                try user.setObject(accountEntity, forKey: "Account")
                completion(.success(true))
            } catch {
                completion(.failure(LocaleError.requestFailed))
            }
        }.eraseToAnyPublisher()
    }
}
