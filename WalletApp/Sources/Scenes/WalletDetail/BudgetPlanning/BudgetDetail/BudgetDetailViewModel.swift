//
//  BudgetDetailViewModel.swift
//  WalletApp
//
//  Created by Артём Бацанов on 23.11.2023.
//

import Foundation

class BudgetDetailViewModel {
  // MARK: - Properties
  var onNeedsUpdateView: (() -> Void)?
  
  var name: String {
    return budget.name
  }
  
  var category: String {
    return budget.category?.title ?? ""
  }
  
  var period: String {
    let dateFormatter = DateFormatter.dayMonthYearDisplay
    let fromDate = dateFormatter.string(from: budget.beginPeriod ?? Date())
    let toDate = dateFormatter.string(from: budget.endPeriod ?? Date())
    return fromDate + " - " + toDate + " (\(remainderDays))"
  }
  
  var spentAmount: String {
    let currency = CurrencyModelView.WalletsCurrencyType(rawValue: currencyCode)?.title ?? ""
    let currentAmount = NSDecimalNumber(decimal: budget.currentAmount).stringValue
    let maxAmount = NSDecimalNumber(decimal: budget.maxAmount).stringValue
    return currentAmount + "/" + maxAmount + " " + currency
  }
  
  var spentAmountAtPercent: String {
    var spent: Decimal
    let spentInPrecent = (budget.currentAmount / budget.maxAmount) * maxPercent
    spent = spentInPrecent > maxPercent ? maxPercent : spentInPrecent
    return NSDecimalNumber(decimal: spent).stringValue + "%" + " \(R.string.walletDetail.budgetDetailViewModelTo()) " + "\(maxPercent)%"
  }
  
  var remainderDays: String {
    guard let fromDate = budget.beginPeriod, let toDate = budget.endPeriod else { return "" }
    let numberOfDays = fromDate.numberOfDays(toDate)
    return String(numberOfDays)
  }
  
  private let maxPercent: Decimal = 100
  
  private let budget: BudgetModel
  private let currencyCode: String
  
  // MARK: - Init
  init(budget: BudgetModel, currencyCode: String) {
    self.budget = budget
    self.currencyCode = currencyCode
  }
  
  // MARK: - Public methods
  func viewIsReady() {
    onNeedsUpdateView?()
  }
}
