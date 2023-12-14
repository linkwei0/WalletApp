//
//  BudgetCellViewModel.swift
//  WalletApp
//
//  Created by Артём Бацанов on 21.11.2023.
//

import Foundation

protocol BudgetCellViewModelDelegate: AnyObject {
  func cellViewModelDidTap(_ viewModel: BudgetCellViewModel, budget: BudgetModel)
  func cellViewMdodelDidRequestToDeleteBudget(_ viewModel: BudgetCellViewModel, budget: BudgetModel)
}

class BudgetCellViewModel {
  // MARK: - Properties
  weak var delegate: BudgetCellViewModelDelegate?
  
  var onNeedsToUpdateDeletionMode: (() -> Void)?
  
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
  
  var remainderBudget: String {
    let remainder = budget.maxAmount - budget.currentAmount
    return remainder > 0 ? NSDecimalNumber(decimal: remainder).stringValue : budgetOutOfBounds
  }
  
  var progress: CGFloat {
    let percentValue = CGFloat(NSDecimalNumber(decimal: budget.currentAmount / budget.maxAmount).doubleValue)
    return percentValue < maxPercent ? percentValue : maxPercent
  }
  
  var currencyTitle: String {
    guard let currency = CurrencyModelView.WalletsCurrencyType(rawValue: currencyCode) else { return "" }
    return currency.title
  }
  
  private var deletionModeIsActive = false
  
  private let numberOfDaysInWeek = 7
  private let maxPercent: CGFloat = 1
  private let budgetOutOfBounds: String = "0"
  
  private let budget: BudgetModel
  private let currencyCode: String
  
  // MARK: - Init
  init(_ budget: BudgetModel, currencyCode: String) {
    self.budget = budget
    self.currencyCode = currencyCode
  }
  
  // MARK: - Public methods
  func didTapDeleteButton() {
    delegate?.cellViewMdodelDidRequestToDeleteBudget(self, budget: budget)
  }
  
  func deletionMode(isActive: Bool) {
    deletionModeIsActive = isActive
  }
}

// MARK: - TableCellViewModel
extension BudgetCellViewModel: TableCellViewModel {
  var tableReuseIdentifier: String {
    return BudgetCell.reuseIdentifiable
  }
  
  func select() {
    if !deletionModeIsActive {
      delegate?.cellViewModelDidTap(self, budget: budget)
    } else {
      onNeedsToUpdateDeletionMode?()
      deletionMode(isActive: false)
    }
  }
}
