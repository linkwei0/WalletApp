//
//  Persistent+Transient.swift
//  WalletApp
//

import CoreData

protocol Persistent {
  associatedtype DomainModel: Domain
  @discardableResult func makeDomain() -> DomainModel?
}

protocol Domain {
  associatedtype PersistentModel: Persistent
  @discardableResult func makePersistent(context: NSManagedObjectContext) -> PersistentModel?
}
