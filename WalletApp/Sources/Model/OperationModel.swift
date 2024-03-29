//
//  OperationModel.swift
//  WalletApp
//

import Foundation
import CoreData

struct OperationModel: Domain {
  let id: Int
  let walletId: Int
  var name: String
  var amount: Decimal
  var category: String
  var definition: String?
  var date: Date
  
  var type: OperationType
  
  func makePersistent(context: NSManagedObjectContext) -> CDOperation? {
    let operation = CDOperation(context: context)
    operation.id = Int64(id)
    operation.walletId = Int64(walletId)
    operation.name = name
    operation.type = type.rawValue
    operation.amount = NSDecimalNumber(decimal: amount)
    operation.category = category
    operation.definition = definition
    operation.date = date
    return operation
  }
}
