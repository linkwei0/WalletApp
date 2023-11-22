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
    if let beginDate = budget.beginPeriod, let endDate = budget.endPeriod,
        let countOfDays = beginDate.interval(to: endDate).day {
      if countOfDays > numberOfDaysInWeek {
        return SelectPeriodTypes.monthly.title
      } else {
        return SelectPeriodTypes.weekly.title
      }
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
    let percentValue = CGFloat(NSDecimalNumber(decimal: budget.currentAmount / budget.maxAmount).doubleValue)
    return percentValue < maxPercent ? percentValue : maxPercent
  }
  
  private let numberOfDaysInWeek = 7
  private let maxPercent: CGFloat = 1
  
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
