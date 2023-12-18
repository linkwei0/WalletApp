//
//  OperationTotalViewModel.swift
//  WalletApp
//
//  Created by Артём Бацанов on 07.11.2023.
//

import UIKit

protocol OperationMonthCardViewModelDelegate: AnyObject {
  func cardViewModelDidRequestToShowOperationList(_ viewModel: OperationMonthCardViewModel, categoryName: String,
                                                  operations: [OperationModel])
}

class OperationMonthCardViewModel {
  // MARK: - Properties
  weak var delegate: OperationMonthCardViewModelDelegate?
  
  var title: String {
    return isIncomeCard ? R.string.walletDetail.monthCardViewTitleIncome() : R.string.walletDetail.monthCardViewTitleExpense()
  }
  
  var category: String {
    return categoryResult
  }
  
  var totalAmount: String {
    return amountResult
  }
  
  var titleTextColor: UIColor {
    if operations.isEmpty {
      return .baseWhite
    }
    return isIncomeCard ? .incomeBtnColor : .expenseColor
  }
  
  private var amountResult: String = ""
  private var categoryResult: String = ""
  
  private let operations: [OperationModel]
  private let isIncomeCard: Bool
  
  private let defaultCardAmount: String = "0"
  
  // MARK: - Init
  init(operations: [OperationModel], isIncome: Bool) {
    self.operations = operations
    self.isIncomeCard = isIncome
    configureViewModelFields()
  }
  
  // MARK: - Public methods
  func didTapCardView() {
    delegate?.cardViewModelDidRequestToShowOperationList(self, categoryName: category, operations: operations)
  }
  
  // MARK: - Private methods
  private func configureViewModelFields() {
    var maxIncomeValue: Decimal = 0
    var maxExpenseValue: Decimal = 0
    
    var incomeCategoryDict: [IncomeCategoryTypes: Decimal] = [:]
    IncomeCategoryTypes.allCases.forEach { incomeCategoryDict[$0] = 0 }
    
    var expenseCategoryDict: [ExpenseCategoryTypes: Decimal] = [:]
    ExpenseCategoryTypes.allCases.forEach { expenseCategoryDict[$0] = 0 }

    operations.forEach { operation in
      if operation.type == .income {
        maxIncomeValue = handleIncomeOperations(operation, &incomeCategoryDict)
      } else {
        maxExpenseValue = handleExpenseOperations(operation, &expenseCategoryDict)
      }
    }

    let incomeValue: String = maxIncomeValue != 0 ? "+" 
    + NSDecimalNumber(decimal: maxIncomeValue).intValue.makeDigitSeparator() : defaultCardAmount
    let expenseValue: String = maxExpenseValue != 0 ? "-"
    + NSDecimalNumber(decimal: maxExpenseValue).intValue.makeDigitSeparator() : defaultCardAmount
    
    amountResult = isIncomeCard ? incomeValue : expenseValue
  }
  
  private func handleIncomeOperations(_ operation: OperationModel,
                                      _ incomeCategoryDict: inout [IncomeCategoryTypes: Decimal]) -> Decimal {
    let category = IncomeCategoryTypes(rawValue: operation.category) ?? .salary
    
    switch category {
    case .present:
      if let value = incomeCategoryDict[.present] {
        incomeCategoryDict[.present] = value + operation.amount
      }
    case .salary:
      if let value = incomeCategoryDict[.salary] {
        incomeCategoryDict[.salary] = value + operation.amount
      }
    case .partjob:
      if let value = incomeCategoryDict[.partjob] {
        incomeCategoryDict[.partjob] = value + operation.amount
      }
    case .dividends:
      if let value = incomeCategoryDict[.dividends] {
        incomeCategoryDict[.dividends] = value + operation.amount
      }
    }
    
    let maxCategory = incomeCategoryDict.max { currentCategory, nextCategory in currentCategory.value < nextCategory.value }
    categoryResult = (maxCategory?.key ?? .present).title
    
    return maxCategory?.value ?? 0
  }
  
  private func handleExpenseOperations(_ operation: OperationModel,
                                       _ expenseCategoryDict: inout [ExpenseCategoryTypes: Decimal]) -> Decimal {
    let category = ExpenseCategoryTypes(rawValue: operation.category) ?? .food

    switch category {
    case .food:
      if let value = expenseCategoryDict[.food] {
        expenseCategoryDict[.food] = value + operation.amount
      }
    case .house:
      if let value = expenseCategoryDict[.house] {
        expenseCategoryDict[.house] = value + operation.amount
      }
    case .phone:
      if let value = expenseCategoryDict[.phone] {
        expenseCategoryDict[.phone] = value + operation.amount
      }
    case .car:
      if let value = expenseCategoryDict[.car] {
        expenseCategoryDict[.car] = value + operation.amount
      }
    case .transport:
      if let value = expenseCategoryDict[.transport] {
        expenseCategoryDict[.transport] = value + operation.amount
      }
    }
    
    let maxCategory = expenseCategoryDict.max { currentCategory, nextCategory in currentCategory.value < nextCategory.value }
    categoryResult = (maxCategory?.key ?? .food).title
    
    return maxCategory?.value ?? 0
  }
}
