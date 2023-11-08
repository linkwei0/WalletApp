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

  private var incomeOperationViewModels: [OperationModel] = []
  private var expenseOperationViewModels: [OperationModel] = []
  
  private let operations: [OperationModel]

  // MARK: - Init
  init(operations: [OperationModel]) {
    self.operations = operations
    configureCardViewModels(operations: operations)
  }
  
  // MARK: - Private methods
  private func configureCardViewModels(operations: [OperationModel]) {
    operations.forEach { operation in
      switch operation.type {
      case .income:
        incomeOperationViewModels.append(operation)
      case .expense:
        expenseOperationViewModels.append(operation)
      }
    }
    incomeCardViewModel = OperationMonthCardViewModel(operations: incomeOperationViewModels)
    expenseCardViewModel = OperationMonthCardViewModel(operations: expenseOperationViewModels)
  }
}

// MARK: - TableHeaderFooterViewModel
extension OperationLastSectionFooterViewModel: TableFooterViewModel {
  var tableReuseIdentifier: String {
    OperationLastSectionFooterView.reuseIdentifiable
  }
}
