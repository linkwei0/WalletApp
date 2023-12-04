//
//  OperationFooterViewModel.swift
//  WalletApp
//
//  Created by Артём Бацанов on 07.11.2023.
//

import Foundation

class OperationLastSectionFooterViewModel {
  // MARK: - Properties
  private(set) var incomeCardViewModel: OperationMonthCardViewModel?
  private(set) var expenseCardViewModel: OperationMonthCardViewModel?
  
  private let operations: [OperationModel]

  // MARK: - Init
  init(operations: [OperationModel]) {
    self.operations = operations
    configureCardViewModels(operations: operations)
  }
  
  // MARK: - Private methods
  private func configureCardViewModels(operations: [OperationModel]) {
    var incomeOperations: [OperationModel] = []
    var expenseOperations: [OperationModel] = []
    operations.forEach { operation in
      
      if operation.date.isCurrentMonth() {
        switch operation.type {
        case .income:
          incomeOperations.append(operation)
        case .expense:
          expenseOperations.append(operation)
        }
      }
    }
    
    incomeCardViewModel = OperationMonthCardViewModel(operations: incomeOperations, isIncome: true)
    expenseCardViewModel = OperationMonthCardViewModel(operations: expenseOperations, isIncome: false)
  }
}

// MARK: - TableHeaderFooterViewModel
extension OperationLastSectionFooterViewModel: TableFooterViewModel {
  var tableReuseIdentifier: String {
    OperationLastSectionFooterView.reuseIdentifiable
  }
}
