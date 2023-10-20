//
//  Persistent+Transient.swift
//  WalletApp
//
//  Created by Артём Бацанов on 10.10.2023.
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
