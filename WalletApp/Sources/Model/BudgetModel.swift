//
//  BudgetModel.swift
//  WalletApp
//
//  Created by Артём Бацанов on 21.11.2023.
//

import Foundation
import CoreData

struct BudgetModel: Domain {
  let id: Int
  var walletID: Int
  var amount: Decimal
  var beginPeriod: Date?
  var endPeriod: Date?
  var name: String
  var category: ExpenseCategoryTypes?
  
  func makePersistent(context: NSManagedObjectContext) -> CDBudget? {
    let budget = CDBudget(context: context)
    budget.id = Int64(id)
    budget.walletID = Int64(walletID)
    budget.amount = NSDecimalNumber(decimal: amount)
    budget.beginDate = beginPeriod
    budget.endDate = endPeriod
    budget.name = name
    budget.category = category?.title
    return budget
  }
}

extension BudgetModel {
  static func makeCleanModel() -> BudgetModel {
    return BudgetModel(id: UUID().hashValue, walletID: UUID().hashValue, amount: 0, name: "", category: .food)
  }
}
