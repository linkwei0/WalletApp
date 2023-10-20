//
//  Managed.swift
//  WalletApp
//
//  Created by Артём Бацанов on 20.09.2023.
//

import CoreData

protocol Managed {
  static var entityName: String { get }
  static var defaultSortDescriptors: [NSSortDescriptor] { get }
}

extension Managed {
  static var defaultSortDescriptors: [NSSortDescriptor] {
    return []
  }
}

extension Managed where Self: NSManagedObject {
  static var entityName: String {
    return entity().name!
  }
  
  static func count(in context: NSManagedObjectContext, configurationBlock: (NSFetchRequest<Self>) -> Void = { _ in }) -> Int {
    let request = NSFetchRequest<Self>(entityName: Self.entityName)
    configurationBlock(request)
    return (try? context.count(for: request)) ?? 0
  }
  
  static func fetch(in context: NSManagedObjectContext, with sortDescriptors: [NSSortDescriptor] = defaultSortDescriptors,
                    configurationBlock: (NSFetchRequest<Self>) -> Void = { _ in }) -> [Self] {
    let request = NSFetchRequest<Self>(entityName: Self.entityName)
    request.sortDescriptors = sortDescriptors
    configurationBlock(request)
    return (try? context.fetch(request)) ?? []
  }
}
