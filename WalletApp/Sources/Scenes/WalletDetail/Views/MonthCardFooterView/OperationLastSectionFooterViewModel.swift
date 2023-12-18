//
//  OperationFooterViewModel.swift
//  WalletApp
//
//  Created by Артём Бацанов on 07.11.2023.
//

import Foundation

protocol OperationLastSectionFooterViewModelDelegate: AnyObject {
  func footerViewModelDidRequestToShowOperationList(_ viewModel: OperationLastSectionFooterViewModel, categoryName: String,
                                                    operations: [OperationModel])
}

class OperationLastSectionFooterViewModel {
  // MARK: - Properties
  weak var delegate: OperationLastSectionFooterViewModelDelegate?
  
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
    incomeCardViewModel?.delegate = self
    expenseCardViewModel = OperationMonthCardViewModel(operations: expenseOperations, isIncome: false)
    expenseCardViewModel?.delegate = self
  }
}

// MARK: - TableHeaderFooterViewModel
extension OperationLastSectionFooterViewModel: TableFooterViewModel {
  var tableReuseIdentifier: String {
    OperationLastSectionFooterView.reuseIdentifiable
  }
}

// MARK: - OperationMonthCardViewModelDelegate
extension OperationLastSectionFooterViewModel: OperationMonthCardViewModelDelegate {
  func cardViewModelDidRequestToShowOperationList(_ viewModel: OperationMonthCardViewModel, categoryName: String,
                                                  operations: [OperationModel]) {
    delegate?.footerViewModelDidRequestToShowOperationList(self, categoryName: categoryName, operations: operations)
  }
}
