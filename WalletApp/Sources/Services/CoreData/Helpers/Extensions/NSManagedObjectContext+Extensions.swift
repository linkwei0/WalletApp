//
//  NSManagedObjectContext+Extensions.swift
//  WalletApp
//
//  Created by Артём Бацанов on 20.09.2023.
//

import CoreData

extension NSManagedObjectContext {
  func insertObject<Object: NSManagedObject>() -> Object where Object: Managed {
    guard let obj = NSEntityDescription.insertNewObject(forEntityName: Object.entityName, into: self) as? Object else {
      fatalError("Failed with type of object")
    }
    return obj
  }
  
  func performChanges(block: @escaping () -> Void) {
    perform {
      block()
      self.saveOrRollback()
    }
  }
  
  @discardableResult
  func saveOrRollback() -> Bool {
    do {
      try save()
      return true
    } catch {
      rollback()
      return false
    }
  }
}
