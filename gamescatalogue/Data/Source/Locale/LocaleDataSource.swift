//
//  LocaleDataSource.swift
//  gamescatalogue
//
//  Created by Alfa Centaury on 04/11/21.
//

import Foundation
import CoreData
import RxSwift

protocol LocaleDataSourceProtocol: AnyObject {
    func getAllFavorite() -> Observable<[GameEntity]>
    
    func getFavorite(_ id: Int) -> Observable<GameEntity>
    
    func setFavorite(_ gameEntity: GameEntity) -> Observable<Bool>
    
    func deleteAllFavorite() -> Observable<Bool>
    
    func deleteFavorite(_ id: Int) -> Observable<Bool>
    
    func loadUserAccount() -> Observable<AccountEntity>
    
    func addUserAccount(_ accountEntity: AccountEntity) -> Observable<Bool>
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
    func getAllFavorite() -> Observable<[GameEntity]> {
        return Observable<[GameEntity]>.create { observer in
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
                    observer.onNext(games)
                    observer.onCompleted()
                } catch {
                    observer.onError(LocaleError.invalidInstance)
                }
            }
            
            return Disposables.create()
        }
    }
    
    func getFavorite(_ id: Int) -> Observable<GameEntity> {
        return Observable<GameEntity>.create { observer in
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
                        
                        observer.onNext(game)
                        observer.onCompleted()
                    }
                } catch {
                    observer.onError(LocaleError.invalidInstance)
                }
            }
            
            return Disposables.create()
        }
    }
    
    func setFavorite(_ gameEntity: GameEntity) -> Observable<Bool> {
        return Observable<Bool>.create { observer in
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
                        observer.onNext(true)
                        observer.onCompleted()
                    } catch {
                        observer.onError(LocaleError.requestFailed)
                    }
                }
            }
            
            return Disposables.create()
        }
    }
    
    func deleteAllFavorite() -> Observable<Bool> {
        return Observable<Bool>.create { observer in
            let taskContext = self.newTaskContext
            taskContext.perform {
                let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Games")
                let batchDeleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
                batchDeleteRequest.resultType = .resultTypeCount
                
                if let batchDeleteResult = try? taskContext.execute(batchDeleteRequest) as? NSBatchDeleteResult {
                    if batchDeleteResult.result != nil {
                        observer.onNext(true)
                        observer.onCompleted()
                    } else {
                        observer.onError(LocaleError.requestFailed)
                    }
                }
            }
            
            return Disposables.create()
        }
    }
    
    func deleteFavorite(_ id: Int) -> Observable<Bool> {
        return Observable<Bool>.create { observer in
            let taskContext = self.newTaskContext
            taskContext.perform {
                let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Games")
                fetchRequest.fetchLimit = 1
                fetchRequest.predicate = NSPredicate(format: "id == \(id)")
                let batchDeleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
                batchDeleteRequest.resultType = .resultTypeCount
                
                if let batchDeleteResult = try? taskContext.execute(batchDeleteRequest) as? NSBatchDeleteResult {
                    if batchDeleteResult.result != nil {
                        observer.onNext(true)
                        observer.onCompleted()
                    } else {
                        observer.onError(LocaleError.requestFailed)
                    }
                }
            }
            
            return Disposables.create()
        }
    }
    
    func loadUserAccount() -> Observable<AccountEntity> {
        return Observable<AccountEntity>.create { observer in
            let user = self.userDefault
            
            do {
                let account = try user.getObject(forKey: "Account", castTo: AccountEntity.self)
                observer.onNext(account)
                observer.onCompleted()
            } catch {
                observer.onError(LocaleError.requestFailed)
            }
            
            return Disposables.create()
        }
    }
    
    func addUserAccount(_ accountEntity: AccountEntity) -> Observable<Bool> {
        return Observable<Bool>.create { observer in
            let user = self.userDefault
            
            do {
                try user.setObject(accountEntity, forKey: "Account")
                observer.onNext(true)
                observer.onCompleted()
            } catch {
                observer.onError(LocaleError.requestFailed)
            }
            
            return Disposables.create()
        }
    }
}
