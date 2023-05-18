//
//  CoreDataManager.swift
//  WalletApp
//

import UIKit
import CoreData

private extension Constants {
  static let nameOfDB = "WalletApp"
}

final class CoreDataManager {
  private lazy var persistentContainer: NSPersistentContainer = {
    let persistentContainer = NSPersistentContainer(name: Constants.nameOfDB)
    persistentContainer.loadPersistentStores { _, error in
      if error != nil {
        print(error?.localizedDescription ?? "")
        return
      }
    }
    return persistentContainer
  }()
  
  var viewContext: NSManagedObjectContext {
    return persistentContainer.viewContext
  }
  
  func fetchObjects<T: NSManagedObject>(entity: T.Type, predicate: NSPredicate? = nil,
                                        sortDescriptors: [NSSortDescriptor]? = nil,
                                        context: NSManagedObjectContext) -> [T] {
    let request = NSFetchRequest<T>(entityName: String(describing: entity))
    request.predicate = predicate
    request.sortDescriptors = sortDescriptors
    
    do {
      return try context.fetch(request)
    } catch {
      print(error.localizedDescription)
      return []
    }
  }
  
  func fetchObject<T: NSManagedObject>(entity: T.Type, predicate: NSPredicate? = nil,
                                       sortDescriptors: [NSSortDescriptor]? = nil,
                                       context: NSManagedObjectContext) -> T? {
    let request = NSFetchRequest<T>(entityName: String(describing: entity))
    request.predicate = predicate
    request.sortDescriptors = sortDescriptors
    request.fetchLimit = 1
    
    do {
      return try context.fetch(request).first
    } catch {
      print(error.localizedDescription)
      return nil
    }
  }
}
