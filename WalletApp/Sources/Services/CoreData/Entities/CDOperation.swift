//
//  CDOperation+CoreDataClass.swift
//  WalletApp
//
//  Created by Артём Бацанов on 20.09.2023.
//
//

import CoreData

extension CDOperation: Persistent {
  func makeDomain() -> OperationModel? {
    guard let name = name, let definition = definition, let date = date else { return nil }
    return OperationModel(id: Int(id), name: name, definition: definition, date: date)
  }
}
