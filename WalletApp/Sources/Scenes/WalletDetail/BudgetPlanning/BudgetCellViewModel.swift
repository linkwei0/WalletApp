//
//  BudgetCellViewModel.swift
//  WalletApp
//
//  Created by Артём Бацанов on 21.11.2023.
//

import Foundation

class BudgetCellViewModel {
  // MARK: - Properties
  var period: String {
    if let begin = budget.beginPeriod, let end = budget.endPeriod, 
        let countOfDays = Calendar.current.dateComponents([.day], from: begin, to: end).day {
      return "На \(countOfDays) дней"
    }
    return ""
  }
  
  var category: String? {
    return budget.category?.title
  }
  
  var amount: String {
    return NSDecimalNumber(decimal: budget.amount).stringValue
  }
  
  private let budget: BudgetModel
  
  // MARK: - Init
  init(_ budget: BudgetModel) {
    self.budget = budget
  }
}

// MARK: - TableCellViewModel
extension BudgetCellViewModel: TableCellViewModel {
  var tableReuseIdentifier: String {
    return BudgetCell.reuseIdentifiable
  }
}
