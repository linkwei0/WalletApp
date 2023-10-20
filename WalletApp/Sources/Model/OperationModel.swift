//
//  OperationModel.swift
//  WalletApp
//

import Foundation
import CoreData

struct OperationModel: Domain {
  let id: Int
  let name: String
  let definition: String?
  let date: Date?
  
  func makePersistent(context: NSManagedObjectContext) -> CDOperation? {
    let operation = CDOperation(context: context)
    operation.id = Int64(id)
    operation.name = name
    operation.definition = definition
    operation.date = date
    return operation
  }
}
