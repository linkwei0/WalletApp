//
//  CoreDataStack.swift
//  WalletApp
//
//  Created by Артём Бацанов on 07.08.2023.
//

import CoreData

final class CoreDataStack {
  let writeContext: NSManagedObjectContext
  let readContext: NSManagedObjectContext
  
  private let persistentContainer = NSPersistentContainer(name: Constants.modelName)
  
  init() {
    persistentContainer.loadPersistentStores { _, error in
      if let error = error {
        fatalError("Failed load persistentContainer - \(error.localizedDescription)")
      }
    }
    readContext = persistentContainer.viewContext
    writeContext = persistentContainer.newBackgroundContext()
    writeContext.mergePolicy = NSMergeByPropertyStoreTrumpMergePolicy
  }
  
  func createObject<Entity: Domain>(_ object: Entity) throws {
    object.makePersistent(context: writeContext)
    try saveWriteContext()
  }
  
  func getObjectByValue<Entity: NSManagedObject>(columnName: String, value: String, type: Entity.Type) -> [Entity] {
    let fetchRequest = createFetchRequest(columnName: columnName, value: value, objectType: type)
    do {
      return try readContext.fetch(fetchRequest)
    } catch {
      return []
    }
  }
  
  func getAllObjectsOfType<Entity: NSManagedObject>(_ type: Entity.Type) -> [Entity] {
    let fetchRequest: NSFetchRequest<Entity> = NSFetchRequest(entityName: String(describing: type))
    do {
      return try readContext.fetch(fetchRequest)
    } catch {
      return []
    }
  }
  
  func deleteObjectByValue<Entity: NSManagedObject>(columnName: String, value: String, type: Entity.Type) throws {
    let objects = getObjectByValue(columnName: columnName, value: value, type: type, context: writeContext)
    for object in objects { writeContext.delete(object) }
    try saveWriteContext()
  }
  
  func createFetchRequest<Entity: NSManagedObject>(columnName: String, value: String,
                                                   objectType: Entity.Type) -> NSFetchRequest<Entity> {
    let fetchRequest: NSFetchRequest<Entity> = NSFetchRequest(entityName: String(describing: objectType))
    fetchRequest.predicate = NSComparisonPredicate(leftExpression: NSExpression(forKeyPath: columnName),
                                                   rightExpression: NSExpression(forConstantValue: value),
                                                   modifier: .direct, type: .equalTo, options: .caseInsensitive)
    return fetchRequest
  }
  
  func saveWriteContext() throws {
    guard writeContext.hasChanges else { return }
    do {
      try writeContext.save()
    } catch {
      writeContext.rollback()
      throw error
    }
  }
  
  func getObjectByValue<Entity: NSManagedObject>(columnName: String, value: String, type: Entity.Type,
                                                 context: NSManagedObjectContext) -> [Entity] {
    let fetchRequest = createFetchRequest(columnName: columnName, value: value, objectType: type)
    do {
      return try context.fetch(fetchRequest)
    } catch {
      return []
    }
  }
}

private extension Constants {
  static let modelName = "WalletAppModel"
}
