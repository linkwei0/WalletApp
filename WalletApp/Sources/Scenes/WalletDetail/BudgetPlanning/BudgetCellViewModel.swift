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
  
  var maxAmount: String {
    return NSDecimalNumber(decimal: budget.maxAmount).stringValue
  }
  
  var progress: CGFloat {
    let diffValue = budget.currentAmount / budget.maxAmount
    if diffValue < 1 {
      let result = NSDecimalNumber(decimal: diffValue).doubleValue
      return CGFloat(result)
    } else {
      return 1
    }
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
