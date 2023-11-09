//
//  OperationTotalViewModel.swift
//  WalletApp
//
//  Created by Артём Бацанов on 07.11.2023.
//

import UIKit

class OperationMonthCardViewModel {
  // MARK: - Properties
  var title: String {
    return isIncomeCard ? "дохода" : "расхода"
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
    return operations[0].type.isIncome ? .incomeBtnColor : .expenseBtnColor
  }
  
  private var isIncomeCard: Bool
  private var amountResult: String = ""
  private var categoryResult: String = ""
  
  private let operations: [OperationModel]
  
  // MARK: - Init
  init(operations: [OperationModel]) {
    self.operations = operations
    self.isIncomeCard = operations.first?.type == .income ? true : false
    configureViewModelFields()
  }
  
  // MARK: - Private methods
  private func configureViewModelFields() {
    var maxIncomeValue: Decimal = 0
    var maxExpenseValue: Decimal = 0
    
    var incomeCategoryDict: [IncomeCategoryType: Decimal] = [:]
    IncomeCategoryType.allCases.forEach { incomeCategoryDict[$0] = 0 }
    
    var expenseCategoryDict: [ExpenseCategoryType: Decimal] = [:]
    ExpenseCategoryType.allCases.forEach { expenseCategoryDict[$0] = 0 }

    operations.forEach { operation in
      if operation.type == .income {
        maxIncomeValue = handleIncomeOperations(operation, &incomeCategoryDict)
      } else {
        maxExpenseValue = handleExpenseOperations(operation, &expenseCategoryDict)
      }
    }

    let incomeValue: String = maxIncomeValue != 0 ? "+" + String(NSDecimalNumber(decimal: maxIncomeValue).intValue) : "0"
    let expenseValue: String = maxExpenseValue != 0 ? "-" + String(NSDecimalNumber(decimal: maxExpenseValue).intValue) : "0"
    amountResult = isIncomeCard ? incomeValue : expenseValue
  }
  
  private func handleIncomeOperations(_ operation: OperationModel,
                                      _ incomeCategoryDict: inout [IncomeCategoryType: Decimal]) -> Decimal {
    let category = IncomeCategoryType(rawValue: operation.category) ?? .salary
    
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
                                       _ expenseCategoryDict: inout [ExpenseCategoryType: Decimal]) -> Decimal {
    let category = ExpenseCategoryType(rawValue: operation.category) ?? .food

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
