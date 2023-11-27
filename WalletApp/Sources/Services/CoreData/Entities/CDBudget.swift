//
//  CDBudget.swift
//  WalletApp
//
//  Created by Артём Бацанов on 21.11.2023.
//

import Foundation

extension CDBudget: Persistent {
  func makeDomain() -> BudgetModel? {
    guard let maxAmount = maxAmount?.decimalValue, let currentAmount = currentAmount?.decimalValue, let beginDate = beginDate,
            let endDate = endDate, let name = name, let category = category else { return nil }
    
    return BudgetModel(id: Int(id), walletID: Int(walletID), maxAmount: maxAmount, currentAmount: currentAmount,
                       beginPeriod: beginDate, endPeriod: endDate, name: name,
                       category: ExpenseCategoryTypes(rawValue: category), isNotifiable: isNotifiable)
  }
}
