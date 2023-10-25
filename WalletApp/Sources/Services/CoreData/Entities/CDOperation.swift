//
//  CDOperation+CoreDataClass.swift
//  WalletApp
//

import CoreData

extension CDOperation: Persistent {
  func makeDomain() -> OperationModel? {
    guard let name = name, let amount = amount?.decimalValue,
          let category = category else { return nil }
    return OperationModel(id: Int(id), walletId: Int(walletId), name: name, amount: amount,
                          category: category, definition: definition, date: date)
  }
}
